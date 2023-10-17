x = [1, 2, 3, 7, 8, 9];
values = dft(x)

function value = dft(data)
    for i=1:length(data)
        v = (2*pi*-1i)/(length(data)-1);
        tmp = (v * data(i-1) * i-1);
        value = data(i-1) * exp(tmp);
    end
end