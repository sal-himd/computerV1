#Parser.rb
#By : sal-himd

class Parser
	def initialize(opts={})
		@equation = opts.fetch(:equation, nil)
	end

	def is_valid?
		verify_regex =~ @equation ? true : false
	end

	def reduce
		reduce_equation = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

		@equation.split('=')[0].gsub(/\s+/, "").scan(/[\+\-]?[0-9.]+\*X\^[0-9]/).each do |fmt|
			reduce_equation[(/\^/.match(fmt).post_match).to_f] += fmt.to_f
		end

		@equation.split('=')[1].gsub(/\s+/, "").scan(/[\+\-]?[0-9.]+\*X\^[0-9]/).each do |fmt|
			reduce_equation[(/\^/.match(fmt).post_match).to_f] -= fmt.to_f
		end

		@equation = reduce_equation

	end

	def set_power
		@power = 0
		@equation.each_with_index do |equa, index|
			@power = index if equa != 0
		end
		@power
	end

	def set_sign
		signs.each_with_index do |sign, index|
			signs[index] = '- ' if @equation[index] < 0
		end
	end

	def result
		{
			equation: @equation,
			power: @power
		}
	end

	private

	attr_accessor :power

	def verify_regex
		@verify_regex ||= /^((\+ |\- )?[0-9.]+ \* X\^[0-9]? )+((\+ |\- )[0-9.]+ \* X\^[0-9]? )*=( 0|( (\+ |\- )?[0-9.]+ \* X\^[0-9]?)+( (\+ |\- )[0-9.]+ \* X\^[0-9]?)*)$/
	end

	def signs
		@sign ||= ['', '+ ','+ ', '+ ', '+ ', '+ ', '+ ', '+ ', '+ ', '+ ']
	end
end