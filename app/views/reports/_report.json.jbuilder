json.extract! report, :id, :user_id, :report_type_id, :description, :pos_x, :pos_y, :address, :created_at, :updated_at
json.url report_url(report, format: :json)