require 'sinatra'
require 'sinatra/reloader'



@@start = false
@@secret_number = rand(100)
@@counter = 5
@@win = false
@@msg = "Welcome to number guesser"

get '/' do
    guess = params['guess'].to_i
    message = check_guess(guess)
    secret_message = secret_message
    erb :index, :locals => { :number => @@secret_number, :message => message, :secret_message => secret_message}
end

def limit_guess(guess)

  if @@counter == 0 || @@win ==true 
    
    @@win = false
    @@secret_number = rand(100)
    if @@counter == 0
      @@counter = 4
      "You have ran out of guesses. A new number has been given. Guess the new number!"
    else 
      @@counter = 4
      @@msg
    end
  else
    @@counter -= 1
    @@msg 
  end
end

def check_guess(guess)
  if(@@start == false)
    @@start = true
    @@msg
  elsif guess == @@secret_number
    @@msg ="You got it right! Great Job! A new number is ready to guess"
    @@win=true
    limit_guess(guess)
  elsif (guess - 5) > @@secret_number
    @@msg ="Way too high!"
    limit_guess(guess)
  elsif (guess + 5 ) < @@secret_number
    @@msg ="Way too low!"
    limit_guess(guess)
  elsif guess > @@secret_number
    @@msg ="Too high!"
    limit_guess(guess)
  else 
    @@msg ="Too low!"
    limit_guess(guess)
  end

end