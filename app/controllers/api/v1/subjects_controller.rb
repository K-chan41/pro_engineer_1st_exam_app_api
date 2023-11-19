class Api::V1::SubjectsController < Api::V1::BaseController
  skip_before_action :authenticate

  def index
    subjects = Subject.all
    json_string = SubjectSerializer.new(subjects).serializable_hash.to_json
    render json: json_string
  end
end
