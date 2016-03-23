def create_links_with_users
  link = create(:link)
  user = create(:user)
  post :create, { link: { given_url: link.given_url } }, user_id: user.id

  [user, link]
end
