module Rails
  module AddOns
    module Shoulda
      module Matchers
        # Example:
        #
        #    RSpec.describe '/posts', type: :feature do
        #      it {
        #        expect(subject).to implement_create_action(self)
        #          .for(Post)
        #          .within_form('#new_post') {
        #            fill_in 'post[title]', with: 'My first post'
        #          }
        #          .increasing{ |resource_class| resource_class.count }.by(1)
        #      }
        #    end
        #
        def implement_create_action(spec)
          ImplementCreateActionMatcher.new(spec)
        end

        class ImplementCreateActionMatcher
          include RSpec::Matchers

          def initialize(spec)
            @spec = spec
          end

          def id(id)
            @id = id
            self
          end

          def increasing(&block)
            @block = block
            self
          end

          def by(expected_increase)
            @expected_increase = expected_increase
            self
          end
          
          # Resource class that will be created
          def for(resource_class)
            @resource_class = resource_class
            self
          end

          # Specifies the form css id to fill to create the resource.
          def within_form(id, &block)
            @form_id = id
            @form_block = block
            self
          end

          def matches?(base_path)
            @base_path = base_path
            @new_path = "#{@base_path}/new"

            @spec.visit(@new_path)

            @before_count = @block.call(@resource_class)
            @spec.within(@form_id) do
              @form_block.call
              @spec.find('input[name="commit"]').click
            end
            @after_count = @block.call(@resource_class)

            has_correct_status_code && has_correct_current_path && has_increased_resource_count
          end

          def created_resource
            @created_resource ||= @resource_class.first
          end

          def expected_path
            @expected_path ||= "#{@base_path}/#{created_resource.to_param}"
          end

          def has_correct_status_code
            if @spec.status_code == 200
              true
            else
              @error = "Wrong status code [#{@spec.status_code}] instead of [200]"
              false
            end
          end

          def has_increased_resource_count
            if (@before_count + @after_count) == @expected_increase
              true
            else
              @error = "Did not increase by expected [#{@expected_increase}] but by [#{@before_count + @after_count}]"
              false
            end
          end

          def has_correct_current_path
            if @spec.current_path == expected_path
              true
            else
              @error = "Wrong current path [#{@spec.current_path}] instead of [#{expected_path}]"
              false
            end
          end

          def failure_message
            "Should expose create action on #{@new_path}. Error: #{@error}"
          end

          def failure_message_when_negated
            "Should not expose create action on #{@new_path}. Error: #{@error}"
          end

          alias negative_failure_message failure_message_when_negated

          def description
            "expose create action on #{@new_path}"
          end
        end
      end
    end
  end
end