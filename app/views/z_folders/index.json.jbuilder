json.array!(@z_folders) do |folder|
  json.extract! folder, :id, :identifier
  json.url folder_url(folder, format: :json)
end
