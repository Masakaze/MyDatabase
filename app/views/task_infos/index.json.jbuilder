json.array!(@task_infos) do |task_info|
  json.extract! task_info, :id, :string
  json.url task_info_url(task_info, format: :json)
end
