#Resolver.rb
#By : sal-himd

class Resolver
	def initialize(opts={})
		@equation 	= opts.fetch(:equation, [])
		@power 		= opts.fetch(:power, 0)
	end

	def resolve
		case @power
		when 0
			@equation = (@equation[0] == 0 ? solution_message[:infinity] : solution_message[:no_solution])
		when 1
			@equation = (- @equation[0] / @equation[1])
		when 2
			if delta < 0
				@equation = (solution_message[:no_solution])
			elsif delta == 0
				@equation = (- @equation[1] / (2 * @equation[2]))
			else
				@equation =  ([(- @equation[1] - delta.sqrt) / (2 * @equation[2]), (- @equation[1] + delta.sqrt) / (2 * @equation[2])])
			end
		else
			@equation = solution_message[:infinity]
		end
	end

	def result
		@equation
	end

	private

	def delta
		@delta ||= @equation[1]*@equation[1] - 4 * @equation[0] * @equation[2]
	end

	def solution_message
		{
			:infinity => 'infinity',
			:no_solution => 'no solution',
		}
	end
end