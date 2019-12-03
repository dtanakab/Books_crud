# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]

  def show
    @comments = @report.comments
    @comment = @report.comments.new
  end

  def new
    @report = Report.new
  end

  def create
    @report = current_user.reports.build(report_params)
    if @report.save
      redirect_to @report, notice: t("messages.created")
    else
      render :new
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t("messages.updated")
    else
      render :edit
    end
  end

  def destroy
    @report.destroy
    redirect_to current_user, notice: t("messages.destroyed")
  end

  private
    def set_report
      @report = Report.find(params[:id])
    end

    def report_params
      params.require(:report).permit(:title, :content)
    end

    def identity_verification
      if @report.user != current_user
        flash[:notice] = t("messages.userself_only")
        redirect_to root_path
      end
    end
end
