#Numeric.rb
#By : sal-himd

class Numeric
	def my_abs
		result = (self >= 0) ? self : - self
	end
	def convert
		i, f = self.to_i, self.to_f
  		i == f ? i : f
	end
	def sqrt
		precision = 0.00001
   		un = self
		while un * un >= self + precision || un * un <= self - precision
			un = (un + self / un) / 2
        end
        un
    end
end