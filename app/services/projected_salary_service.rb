class ProjectedSalaryService

  def self.for(user)
    new(user).perform
  end

  def initialize(user)
    @user = user
  end


  def perform
    year_of_repayment > 0 ? ajusted_projected_salary : initial_salary_value
  end

  private
   
  def array_modeling_variable
    modeling_variable_hashes = []
    @user.modeling_variable.includes(research_model_info: :research_variable).each do |mv|
      modeling_hash = mv.modeling_hash.with_indifferent_access
      modeling_variable_hashes << [modeling_hash[:value] , modeling_hash[:acronym]]
    end
    modeling_variable_hashes
  end

  #buscar el salario inicial en las multiples variables
  def find_initial_salary_in_array
    income_percentile = @user.income_percentile
    array_modeling_variable.select{|arr| arr.include?("salario_#{income_percentile}")}.flatten
  end

  #buscar la variable de incremento del salario 
  def increase_percentage(year_of_repayment)
    array_increase_percentage(year_of_repayment).reject{|e| e.class == String}.join.to_f
  end

  #determina si ya se completo todo el incremento esperado
  def array_increase_percentage(year_of_repayment)
    acronym = "crecimiento_salarios_#{year_of_repayment}"
    array_modeling_variable.select{|arr| arr.include?(acronym)}.flatten.present? ? array_modeling_variable.select{|arr| arr.include?(acronym)}.flatten : array_modeling_variable.select{|arr| arr.include?('crecimiento_de_salarios_final')}.flatten
  end

  #saber cuantos años lleva pagando
  def repayment_counter
    isa = @user.active_isa.first
    isa.repayment_payed_number
  end

  def year_of_repayment
    return 0 if repayment_counter.nil?

    (repayment_counter/12).to_i
  end

  def array_of_years
    year_of_repayment == 0 ? [0] : (1..year_of_repayment).to_a.uniq
  end

  #devuelve el valor del salario inicial de un usuario
  def initial_salary_value
    income_percentile = @user.income_percentile
    find_initial_salary_in_array.reject{|e| e == "salario_#{income_percentile}"}.join.to_f
  end

  #salario ajustado a las cuotas pagadas
  def ajusted_projected_salary
    array_of_years.inject(initial_salary_value){|salary, year| salary + (salary * increase_percentage(year))}
  end

end