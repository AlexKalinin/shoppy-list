if Rails.env.development?
  User.create email: 'example@domain.com', password: '123456789'
end