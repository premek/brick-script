local lpeg = require "lpeg"

lpeg.locale(lpeg)
local S,C,Ct,Cc,Cg,Cb,Cf,Cmt,Cp,P,V =
  lpeg.S, lpeg.C, lpeg.Ct, lpeg.Cc, lpeg.Cg, lpeg.Cb, lpeg.Cf, lpeg.Cmt, lpeg.Cp,
  lpeg.P, lpeg.V


local eof = -1
local sp = S" \t" ^0 + eof
local wh = S" \t\r\n" ^0 + eof
local nl = S"\r\n" ^1 + eof

local symbols = S":{}()[],. \t\r\n"

local id = C((P(1)-symbols)^1)*sp
local name = Ct(Cc"name" * id * (wh*"."*wh*id)^0) * sp
local num = Ct(Cc"num" * C(lpeg.digit^1)) *sp -- do we really need you? :)
local fnParams = Ct(Cc"params" * "(" * wh * (id * (P"," * wh * id)^0)^0 *wh* ")") *sp

local commentLine = P"//"*((P(1)-nl)^1)*nl
local commentBlock = P"/*" * ((P(1)-"*/")^1)*"*/"*wh
local comment = commentLine + commentBlock

local bit = S"#-" / function(str) return str=="#" and 1 or 0 end
local bitmap = Ct(Cc"bitmap" * Ct(Ct(sp * bit^1 * wh)^1))

local g = P({
 "prog",
 prog = wh* Ct(V'stmt'^0),
 stmt = (comment + V'block' + V'fn' + V'assign' + V'update' + V'list' + bitmap + num + V'call' + name)*wh,

 list = Ct(Cc"list" * P"[" * wh * Ct((V'stmt' * (P"," * wh * V'stmt')^0 * (wh*','*wh)^-1)^-1) * "]"),
 block = Ct(P"{"/"block" * wh * ((V'stmt')^0) * "}"),
 fn = Ct(Cc"fn" * fnParams * wh * V'stmt'),
 assign = Ct(Cc"assign" * name * ":" * wh * V'stmt'),
 update = Ct(Cc"update" * name * "<<" * wh * V'stmt'),
 args = V'stmt'^-1 * ("," * wh * V'stmt' ) ^0,
 call = Ct(Cc"call" * name * wh *Ct(("(" * wh * V'args'* ")")^-1  * V'block'^-1)), -- TODO the block prameter needs arguments

})

return g;
