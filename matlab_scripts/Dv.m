function dv = Dv(w)
R = 3.93;
lambda = 6.328e-7;
dv = w .* ( 2 ./ (R .* lambda)) .^ 0.5;
end