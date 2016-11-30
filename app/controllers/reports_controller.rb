class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, only: [:post_report]
  skip_before_action :verify_authenticity_token, only: [:post_report]

  # GET /reports
  # GET /reports.json
  def index
    if current_user.is_admin?
      @reports = Report.all.order(created_at: :desc)
    elsif current_user.is_jmas?
      @reports = Report.where(:report_type_id => 1).order(created_at: :desc)
    elsif current_user.is_municipio?
      @reports = Report.where(:report_type_id => 2).order(created_at: :desc)
    elsif current_user.is_cfe?
      @reports = Report.where(:report_type_id => 3).order(created_at: :desc)
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.user = current_user
    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def post_report
    @report = Report.new(report_mobile_params)
    #@report.avatar = params[:avatar]
    if @report.save
      render status: 200, json: {
        message: "El reporte se guardo correctamente.",
        report: @report
      }.to_json
    else
      render status: 500, json: {
        message: "Hubo un error al guardar, intentalo de nuevo mas tarde."
      }.to_json
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:user_id, :report_type_id, :description, :pos_x, :pos_y, :address, :avatar)
    end

    def report_mobile_params
       params.permit(:avatar, :user_id, :report_type_id, :description, :pos_x, :pos_y, :address)
    end
end
