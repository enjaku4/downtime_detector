Fabricator(:user) do
  nickname { 'foobar' }
  # hash for password 'password'
  password { '$2a$12$7hNRLP7aoKa7tXGwl.PW.OZ5C6FbpSaiCd2dm5Uwe9hVw7JYBXSjW' }
end