json.array!(@links) do |link|
  json.extract! link, :id, :given_url, :slug, :clicks, :snapshot, :title
  json.url link_url(link, format: :json)
end
