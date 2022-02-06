class UpdateXirrService

  def self.for(isa_id)
    new(isa_id).perform
  end

  def initialize(isa_id)
    @isa = Isa.find(isa_id)
  end


  def perform
    begin
      if @isa.instance_of? Isa
        update_xirr
      end
    rescue StandardError => e
      return puts e
    end
  end

  private

  def update_xirr
    @isa.funding_option.update_xirr
  end

end