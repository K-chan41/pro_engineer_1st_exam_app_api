class Api::V1::FlagsController < Api::V1::BaseController
  before_action :set_question, only: [:create]
  before_action :set_flag, only: [:destroy]

  def index
    flags = current_user.flags.includes(:question).order(updated_at: :desc)
    json_string = FlagSerializer.new(flags, options).serializable_hash.to_json
    render json: json_string
  end

  def create
    flag = current_user.flags.build(question: @question)
    if flag.save
      render json: flag, status: :created
    else
      render json: { errors: flag.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @flag&.destroy
      head :no_content
    else
      render json: { error: 'フラグが見つからないか削除できませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def set_question
    @question = Question.find_by(id: params[:flag][:question_id])
  end

  def set_flag
    @flag = current_user.flags.find_by(question_id: params[:id])
  end

  def options
    {
      include: [:question] # 'include' オプションを設定
    }
  end
end
