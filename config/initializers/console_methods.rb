module Rails
  class ConsoleMethod

    puts "welcome"
    initialize = instance_method(:initialize)

    define_method :initialize do |*args|
      puts 'Welcome'

      @user = nil
      until @user.present? do
        puts 'Please Enter your email id?'
        email = gets
        @user = Mpc::GlobalUser.find_by_email(email.chomp)
        puts 'Invalid email' unless @user.present?
      end
      puts "Hi #{@user.email}"
      Thread.current[:shard_id] = @user.shard_id
      ActiveRecord::Base.default_shard = @user.shard_id
      initialize.bind(self).call(*args)
        
    end
  end
end
