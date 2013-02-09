class JobTitlesController < ApplicationController
  # GET /job_titles
  # GET /job_titles.json
  def index
    @job_titles = JobTitle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @job_titles }
    end
  end

  # GET /job_titles/1
  # GET /job_titles/1.json
  def show
    @job_title = JobTitle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job_title }
    end
  end

  # GET /job_titles/new
  # GET /job_titles/new.json
  def new
    @job_title = JobTitle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job_title }
    end
  end

  # GET /job_titles/1/edit
  def edit
    @job_title = JobTitle.find(params[:id])
  end

  # POST /job_titles
  # POST /job_titles.json
  def create
    @job_title = JobTitle.new(params[:job_title])

    respond_to do |format|
      if @job_title.save
        format.html { redirect_to @job_title, notice: 'Job title was successfully created.' }
        format.json { render json: @job_title, status: :created, location: @job_title }
      else
        format.html { render action: "new" }
        format.json { render json: @job_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /job_titles/1
  # PUT /job_titles/1.json
  def update
    @job_title = JobTitle.find(params[:id])

    respond_to do |format|
      if @job_title.update_attributes(params[:job_title])
        format.html { redirect_to @job_title, notice: 'Job title was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_titles/1
  # DELETE /job_titles/1.json
  def destroy
    @job_title = JobTitle.find(params[:id])
    @job_title.destroy

    respond_to do |format|
      format.html { redirect_to job_titles_url }
      format.json { head :no_content }
    end
  end
end
