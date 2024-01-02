class Api::V1::FlagsController < Api::V1::BaseController
  before_action :set_question, only: [:create, :destroy]

  def create
    flag = current_user.flags.create(question: @question)
    if flag.save
      render json: flag, status: :created
    else
      render json: { errors: flag.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    flag = current_user.flags.find_by(question: @question)
    if flag&.destroy
      head :no_content
    else
      render json: { error: 'フラグが見つからないか削除できませんでした' }, status: :unprocessable_entity
    end
  end

  private

  def set_question
    @question = Question.find_by(id: params[:id])
  end
end
