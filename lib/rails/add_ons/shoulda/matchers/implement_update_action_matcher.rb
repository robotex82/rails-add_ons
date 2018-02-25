module Rails
  module AddOns
    module Shoulda
      module Matchers
        # Example:
        #
        #    RSpec.describe '/posts', type: :feature do
        #      let(:post) { create(:post) }
        #      it {
        #        expect(subject).to implement_update_action(self)
        #          .for(post)
        #          .within_form('.edit_post') {
        #            fill_in 'post[title]', with: 'New title'
        #            fill_in 'post[body]',  with: 'New body'
        #          }
        #          .updating{ |resource| resource.attributes }
        #          .from(post.attributes)
        #          .to({ 'title' => 'New title', 'body' => 'New body' })
        #      }
        #    end
        #
        def implement_update_action(spec)
          ImplementUpdateActionMatcher.new(spec)
        end

        class ImplementUpdateActionMatcher
          include RSpec::Matchers

          def initialize(spec)
            @spec = spec
          end

          # Resource that will be updated
          def for(resource)
            @resource = resource
            self
          end

          def from(attributes)
            @expected_before_attributes = attributes
            self
          end

          def to(attributes)
            @expected_after_attributes = attributes
            self
          end

          # Specifies the form css id to fill to create the resource.
          def within_form(id, &block)
            @form_id = id
            @form_block = block
            self
          end

          def updating(&block)
            @block = block
            self
          end

          def id
            @resource.to_param
          end

          def matches?(base_path)
            @base_path = base_path
            @show_path = "#{@base_path}/#{id}"
            @edit_path = "#{@base_path}/#{id}/edit"

            @expected_path = @show_path

            @spec.visit(@edit_path)

            return unless has_correct_attributes_before if @expected_before_attributes.present?

            @spec.within(@form_id) do
              @form_block.call
              @spec.find('input[name="commit"]').click
            end
                        
            @resource.reload

            has_correct_status_code && has_correct_current_path && has_correct_attributes_after
          end

          def has_correct_status_code
            if @spec.status_code == 200
              true
            else
              @error = "Wrong status code [#{@spec.status_code}] instead of [200]"
              false
            end
          end

          def has_correct_current_path
            if @spec.current_path == @expected_path
              true
            else
              @error = "Wrong current path [#{@spec.current_path}] instead of [#{@expected_path}]"
              false
            end
          end

          def has_correct_attributes_before
            sliced_resource_attributes = @resource.attributes.with_indifferent_access.slice(*@expected_before_attributes.keys)
            if @expected_before_attributes == sliced_resource_attributes
              true
            else
              @error = "Attributes before update [#{sliced_resource_attributes}] did not match expected attributes [#{@expected_before_attributes}]"
              false
            end
          end

          def has_correct_attributes_after
            sliced_resource_attributes = @resource.attributes.with_indifferent_access.slice(*@expected_after_attributes.keys)
            if @expected_after_attributes == sliced_resource_attributes
              true
            else
              @error = "Attributes after update [#{sliced_resource_attributes}] did not match expected attributes [#{@expected_after_attributes}]"
              false
            end
          end

          def failure_message
            "Should expose update action on #{@edit_path}. Error: #{@error}"
          end

          def failure_message_when_negated
            "Should not expose update action on #{@edit_path}. Error: #{@error}"
          end

          alias negative_failure_message failure_message_when_negated

          def description
            "expose update action on #{@edit_path}"
          end
        end
      end
    end
  end
end