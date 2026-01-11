class Host < User
  default_scope { where(user_type: 'host') }

  attribute :user_type, :string, default: 'host'
end
