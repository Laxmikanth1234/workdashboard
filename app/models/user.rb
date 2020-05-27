class User < ApplicationRecord


  has_many :jobs
  has_many :punches, through: :jobs
  has_many :clocks

devise :database_authenticatable, :registerable, :registerable, :recoverable, :rememberable, :trackable, :validatable  

  def active_for_authentication?
        # Uncomment the below debug statement to view the properties of the returned self model values.
        # logger.debug self.to_yaml
        super && is_active
   end




  def current_clock_in
    self.clocks.where(clock_out: nil).last
  end

  def currently_clocked_in?
    current_clock_in
  end

  def current_clock_type
    if self.clocks.any?
      self.current_clock_in ? "In" : "Out"
    end
  end       

  def total_time_on_user
    total = 0
    self.clocks.each do |clock|
      if clock.clock_out
        clock_in_time = clock.created_at
        clock_out_time = clock.clock_out
        total_time = clock_out_time - clock_in_time
        total += total_time
      end
    end
    total
  end

  def today_first_clockin_time
    today = []
    self.clocks.each do |clock|
      if clock.created_at.strftime("%d%m%Y").to_s == Time.now.strftime("%d%m%Y").to_s
        today << clock.created_at
      end
    end
    today
  end

  def today_time_on_user
    total = 0
    self.clocks.each do |clock|
      if clock.clock_out && clock.created_at.strftime("%d%m%Y").to_s == Time.now.strftime("%d%m%Y").to_s
        clock_in_time = clock.created_at
        clock_out_time = clock.clock_out
        total_time = clock_out_time - clock_in_time
        total += total_time
      end
    end
    total
  end

  # def today_jobs
  #   today = []
  #   self.jobs.each do |job|
  #     if job.created_at.strftime("%d%m%Y").to_s == Time.now.strftime("%d%m%Y").to_s
  #       today << job
  #     end
  #   end
  #   today
  # end

end
