local lpeg = require "lpeg"

lpeg.locale(lpeg)
local S,C,Ct,Cc,Cg,Cb,Cf,Cmt,Cp,P,V =
  lpeg.S, lpeg.C, lpeg.Ct, lpeg.Cc, lpeg.Cg, lpeg.Cb, lpeg.Cf, lpeg.Cmt, lpeg.Cp,
  lpeg.P, lpeg.V


local eof = -1
local sp = S" \t" ^0 + eof
local wh = S" \t\r\n" ^0 + eof
local nl = S"\r\n" ^1 + eof

local dig = lpeg.digit
local symbols = S":{}()[],. \t\r\n"

local id = C((1-dig-symbols-'#')*(P(1)-symbols)^0)*sp
local name = Ct(Cc"name" * id)*sp
local num = Ct(Cc"num" * C(dig^1)) *sp -- do we really need you? :)
local fnParams = Ct(Cc"params" * "(" * wh * (id * (P"," * wh * id)^0)^0 *wh* ")") *sp
local argSep = P","*wh

local commentLine = P"//"*((P(1)-nl)^1)*nl
local commentBlock = P"/*" * ((P(1)-"*/")^1)*"*/"*wh
local comment = commentLine + commentBlock

local bit = S"#-" / function(str) return str=="#" and 1 or 0 end
local bitmap = Ct(Cc"bitmap" * Ct(Ct(sp * bit^1 * wh)^1))

local g = P({
 "prog",
 prog = wh* Ct(V'stmt'^0),
 stmt = (comment + V'fn' + V'assign' + V'update'  + V'call' + V'block' + V'list'+  num+ bitmap+name)*wh,

 list = Ct(Cc"list" * P"[" * wh * argSep^-1 * Ct((V'stmt' * (P"," * wh * V'stmt')^0 * (wh*','*wh)^-1)^-1) * "]"),
 block = Ct(P"{"/"block" * wh * ((V'stmt')^0) * "}"),
 fn = Ct(Cc"fn" * fnParams * wh * V'stmt'), -- FIXME
 assign = Ct(Cc"assign" * name * ":" * wh * V'stmt'),
 update = Ct(Cc"update" * name * "<<" * wh * V'stmt'),
 callArgs =  "(" * wh *( argSep^-1 * V'stmt' * (argSep * wh * V'stmt' )^0 * argSep^-1)^-1* ")"*wh,
 call  = Ct(Cc"call" *(((V'block'+V'list'+num+bitmap+name)*'.'*wh)+Ct(0)) * id * wh *Ct(V'callArgs'^-1 * V'block'^-1)), -- TODO the block prameter needs arguments

})

return g;
