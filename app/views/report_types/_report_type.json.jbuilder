json.extract! report_type, :id, :description, :created_at, :updated_at
json.url report_type_url(report_type, format: :json)