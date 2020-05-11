# frozen_string_literal: true

class HealthController < ApplicationController

  def check
    ActiveRecord::Base.connection.execute("SELECT 1")
    render json: { status: "OK" }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :service_unavailable
  end
end
