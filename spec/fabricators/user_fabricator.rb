Fabricator(:user) do
  nickname { 'foobar' }
  # hash and salt for password 'password'
  password_hash { '$2a$12$PXGKAGZu.Gq0wCzUdP44tugTCLEOIMxpVcDEIywfDFQ3SRdTc5Vj6' }
  password_salt { '$2a$12$PXGKAGZu.Gq0wCzUdP44tu' }
end