module Gitlab
  class Client
    # Defines methods related to label.
    #
    # See [http://docs.gitlab.com/ce/api/labels.html](http://docs.gitlab.com/ce/api/labels.html)
    module Label
      # Gets a list labels in a project.
      #
      # - param  [Int32] project_id The ID of a project.
      # - param  [Hash] params A customizable set of params.
      # - option params [String] :page The page number.
      # - option params [String] :per_page The number of results per page. default is 20
      # - return [JSON::Any] List of issues under a project.
      #
      # ```
      # client.labels(1)
      # client.labels(1, {"per_page" => "10"})
      # ```
      def labels(project_id : Int32, params : Hash? = nil) : JSON::Any
        get("projects/#{project_id}/labels", params: params).parse
      end

      # Create label in a project.
      #
      # - param  [Int32] project_id The ID of a project.
      # - param  [String] name The name of a label.
      # - param  [String] color The color of the label in 6-digit hex notation with leading # sign.
      # - param [String] description The description of the label.
      # - return [JSON::Any] Information about the created label in a project.
      #
      # ```
      # client.create_label(1, "hotfix", "#E2C08D")
      # client.create_label(1, "feature", "#C678DD", "next release features")
      # ```
      def create_label(project_id : Int32, name : String, color : String, description : String? = nil) : JSON::Any
        form = Hash(String, String).new.tap do |obj|
          obj["name"] = name
          obj["color"] = color
          obj["description"] = description if description
        end

        post("projects/#{project_id}/labels", form: form).parse
      end

      # Edit a label in a project.
      #
      # - param  [Int32] project_id The ID of a project.
      # - param  [String] name The name of a label.
      # - param  [Hash] params A customizable set of params.
      # - option params [String] :new_name The new name of the label.
      # - option params [String] :color The color of the label in 6-digit hex notation with leading # sign.
      # - option params [String] :description The description of the label.
      # - return [JSON::Any] Information about the updated label in a project.
      #
      # ```
      # client.edit_label(1, "hotfix", {"new_name" => "bugs"})
      # client.edit_label(1, "hotfix", {"color" => "#BE5046"})
      # ```
      def edit_label(project_id : Int32, name : String, form : Hash = {} of String => String) : JSON::Any
        put("projects/#{project_id}/labels", form: {
          "name" => name,
        }.merge(form)).parse
      end

      # Delete a label in a project.
      #
      # - param  [Int32] project_id The ID of a project.
      # - param  [String] name The name of a label.
      # - return [JSON::Any] Information about the deleted label.
      #
      # ```
      # client.delete_issue(4, 3)
      # ```
      def delete_label(project_id : Int32, name : String) : JSON::Any | Bool
        response = delete("projects/#{project_id}/labels", form: {"name" => name})
        return true if response.status_code == 204
        response.parse
      end

      # Subscribe a label in a project.
      #
      # - param  [Int32] project_id The ID of a project.
      # - param  [Int32] label_id The ID of a label.
      # - return [JSON::Any] Information about the subscribed label in a project.
      #
      # ```
      # client.subscribe_label(1, 38)
      # ```
      def subscribe_label(project_id : Int32, label_id : Int32 | String) : JSON::Any
        post("projects/#{project_id}/labels/#{label_id}/subscribe").parse
      end

      # Unsubscribe a label in a project.
      #
      # - param  [Int32] project_id The ID of a project.
      # - param  [Int32] label_id The ID of a label.
      # - return [JSON::Any] Information about the subscribed label in a project.
      #
      # ```
      # client.unsubscribe_label(1, 38)
      # ```
      def unsubscribe_label(project_id : Int32, label_id : Int32 | String) : JSON::Any
        post("projects/#{project_id}/labels/#{label_id}/unsubscribe").parse
      end
    end
  end
end
