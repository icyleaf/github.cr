require "../../spec_helper"

describe Gitlab::Client::Note do
  describe "notes" do
    context "when issue notes" do
      it "should return a paginated response of notes" do
        stub_get("/projects/3/issues/7/notes", "notes")
        notes = client.issue_notes(3, 7)

        notes.should be_a JSON::Any
        notes[0]["author"]["name"].as_s.should eq "John Smith"
      end
    end

    context "when snippet notes" do
      it "should return a paginated response of notes" do
        stub_get("/projects/3/snippets/7/notes", "notes")
        notes = client.snippet_notes(3, 7)

        notes.should be_a JSON::Any
        notes[0]["author"]["name"].as_s.should eq "John Smith"
      end
    end

    context "when merge_request notes" do
      it "should return a paginated response of notes" do
        stub_get("/projects/3/merge_requests/7/notes", "notes")
        notes = client.merge_request_notes(3, 7)

        notes.should be_a JSON::Any
        notes[0]["author"]["name"].as_s.should eq "John Smith"
      end
    end
  end

  describe "note" do
    context "when issue note" do
      it "should return information about a note" do
        stub_get("/projects/3/issues/7/notes/1201", "note")
        note = client.issue_note(3, 7, 1201)

        note["body"].as_s.should eq "The solution is rather tricky"
        note["author"]["name"].as_s.should eq "John Smith"
      end
    end

    context "when snippet note" do
      it "should return information about a note" do
        stub_get("/projects/3/snippets/7/notes/1201", "note")
        note = client.snippet_note(3, 7, 1201)

        note["body"].as_s.should eq "The solution is rather tricky"
        note["author"]["name"].as_s.should eq "John Smith"
      end
    end

    context "when merge request note" do
      it "should return information about a note" do
        stub_get("/projects/3/merge_requests/7/notes/1201", "note")
        note = client.merge_request_note(3, 7, 1201)

        note["body"].as_s.should eq "The solution is rather tricky"
        note["author"]["name"].as_s.should eq "John Smith"
      end
    end
  end

  describe "create note" do
    context "when issue note" do
      it "should return information about a created note" do
        form = {"body" => "The solution is rather tricky"}
        stub_post("/projects/3/issues/7/notes", "note", form: form)
        note = client.create_issue_note(3, 7, "The solution is rather tricky")

        note["body"].as_s.should eq "The solution is rather tricky"
        note.["author"]["name"].as_s.should eq "John Smith"
      end
    end

    context "when snippet note" do
      it "should return information about a created note" do
        form = {"body" => "The solution is rather tricky"}
        stub_post("/projects/3/snippets/7/notes", "note", form: form)
        note = client.create_snippet_note(3, 7, "The solution is rather tricky")

        note["body"].as_s.should eq "The solution is rather tricky"
        note["author"]["name"].as_s.should eq "John Smith"
      end
    end

    context "when merge_request note" do
      it "should return information about a created note" do
        form = {"body" => "The solution is rather tricky"}
        stub_post("/projects/3/merge_requests/7/notes", "note", form: form)
        note = client.create_merge_request_note(3, 7, "The solution is rather tricky")

        note["body"].as_s.should eq "The solution is rather tricky"
        note["author"]["name"].as_s.should eq "John Smith"
      end
    end
  end

  describe "delete note" do
    context "when issue note" do
      it "should return information about a deleted issue note" do
        stub_delete("/projects/3/issues/7/notes/1201", "note")
        note = client.delete_issue_note(3, 7, 1201)
        note.should be_a(JSON::Any)
        note.as(JSON::Any)["id"].as_i.should eq 1201
      end

      it "should return true since 9.0" do
        stub_delete("/projects/4/issues/8/notes/1203")
        result = client.delete_issue_note(4, 8, 1203)
        result.should be_true
      end
    end

    context "when snippet note" do
      it "should return information about a deleted snippet note" do
        stub_delete("/projects/3/snippets/7/notes/1201", "note")
        note = client.delete_snippet_note(3, 7, 1201)
        note.should be_a(JSON::Any)
        note.as(JSON::Any)["id"].as_i.should eq 1201
      end

      it "should return true since 9.0" do
        stub_delete("/projects/9/snippets/7/notes/1201")
        result = client.delete_snippet_note(9, 7, 1201)
        result.should be_true
      end
    end

    context "when merge request note" do
      it "should return information about a deleted merge request note" do
        stub_delete("/projects/3/merge_requests/7/notes/1201", "note")
        note = client.delete_merge_request_note(3, 7, 1201)

        note.should be_a(JSON::Any)
        note.as(JSON::Any)["id"].as_i.should eq 1201
      end

      it "should return true since 9.0" do
        stub_delete("/projects/13/merge_requests/7/notes/1201")
        result = client.delete_merge_request_note(13, 7, 1201)
        result.should be_true
      end
    end
  end

  describe "modify note" do
    context "when issue note" do
      it "should return information about a modified issue note" do
        form = {"body" => "edited issue note content"}
        stub_put("/projects/3/issues/7/notes/1201", "note", form: form)
        note = client.edit_issue_note(3, 7, 1201, "edited issue note content")

        note["id"].as_i.should eq 1201
      end
    end

    context "when snippet note" do
      it "should return information about a modified snippet note" do
        form = {"body" => "edited snippet note content"}
        stub_put("/projects/3/snippets/7/notes/1201", "note", form: form)
        note = client.edit_snippet_note(3, 7, 1201, "edited snippet note content")

        note["id"].as_i.should eq 1201
      end
    end

    context "when merge request note" do
      it "should return information about a modified request note" do
        form = {"body" => "edited merge request note content"}
        stub_put("/projects/3/merge_requests/7/notes/1201", "note", form: form)
        note = client.edit_merge_request_note(3, 7, 1201, "edited merge request note content")

        note["id"].as_i.should eq 1201
      end
    end
  end
end
