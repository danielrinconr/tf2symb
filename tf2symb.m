function [tf_symb] = tf2symb(system)
%tf2symb Convert tf object to symbolic object.
% Get num and den of the tf.
[num, den] = tfdata(tf(system));
% Convert cell array to mat array.
num = num{:}; den = den{:};
% Factorize if it is necesary.
num_symb = array2symb(num);
den_symb = array2symb(den);
% Return the symbolic tf
tf_symb = num_symb/den_symb;
end
function str_ = array2symb(array)
%array2symb Convert an mat array to symbolic.
syms s
% Check if it's a grade 1 polynomial.
if length(array(array ~= 0)) == 1
  str_ = poly2sym(array,s);
  return
end

fact_symb = factor(poly2sym(array,s));
% Check if the polynomial is  not factorizable.
if length(fact_symb) <= 1
  str_ = fact_symb;
  return
end
% Replace the array delims to a factorize delims.
str_ = char(fact_symb);
str_([1:8, end-1:end]) = [];
str_ = replace(str_, '[', '(');
str_ = replace(str_, ',', ')*(');
str_ = replace(str_, ']', ')');
str_ = str2sym(str_);
end
