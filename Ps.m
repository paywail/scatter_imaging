function [ y ] = Ps( x,S)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

y=x.*S;
y=min(255,max(0,y));
end

