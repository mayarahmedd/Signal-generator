function valid = validation(v)
valid=v;
while isnan(valid);
    valid=str2double(input('invalid value please enter a valid number','s'));
end
end