local lpeg = require "lpeg"
local inspect = require 'inspect'


lpeg.locale(lpeg)
local S,C,Ct,Cc,Cg,Cb,Cf,Cmt,P,V =
  lpeg.S, lpeg.C, lpeg.Ct, lpeg.Cc, lpeg.Cg, lpeg.Cb, lpeg.Cf, lpeg.Cmt,
  lpeg.P, lpeg.V


local eof = -1
local sp = S" \t" ^0 + eof
local wh = S" \t\r\n" ^0 + eof
local nl = S"\r\n" ^1 + eof

local symbols = S":{}, \t\r\n"
local iid = C((P(1)-symbols)^1)
local id = Ct(Cc"id" * iid) *sp
local num = Ct(Cc"num" * C(lpeg.digit^1)) *sp
local params = Ct(Cc"params" * iid * (P"," * wh * iid)^0) *sp

local commentLine = P"//"*((P(1)-nl)^1)*nl
local commentBlock = P"/*" * ((P(1)-"*/")^1)*"*/"*wh
local comment = commentLine + commentBlock




local g = P({
 "prog",
 prog = Ct(V'stmt'^1),
 stmt = (comment + V'block' + V'assign' + num + id)*wh,

 block = Ct(P"{"/"block" * wh * ((V'stmt')^0) * "}"),
 assign = Ct(Cc"assign" * id * params^0 * ":" * wh * V'stmt'),


})

print(inspect(g:match([[
hello: 4
samesame x: {hi!}
hi: 2

]])));
