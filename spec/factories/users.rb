FactoryBot.define do
  factory :user do
    nickname              {'tanaka'}
    email                 {'test@example'}
    password              {'aaa000'}
    password_confirmation {password}
    first_name             {'田中'}
    last_name              {'元'}
    first_name_kana        {'タナカ'}
    last_name_kana         {'ハジメ'}
    birthday               {'1999-01-01'}
  end
end