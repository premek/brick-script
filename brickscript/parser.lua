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
local idFirstNotAllowed = symbols+dig+S'#-'
local id = C((1-idFirstNotAllowed)*(1-symbols)^0)*sp
local num = Ct(Cc"num" * C(dig^1)) *sp -- do we really need you? :)
local fnParams = Ct(Cc"params" * "(" * wh * (id * (P"," * wh * id)^0)^0 *wh* ")") *sp -- not needed?
local blockParams = wh * Ct((id * (wh * "," * wh * id)^0 *wh*'->')^0) *wh
local argSep = P","*wh

local codeTaskType = (P"TODO" + P"FIXME" + P"XXX")/string.lower
local codeTask = Ct(Cc"task" * codeTaskType * sp * C((P(1)-nl)^1))*nl
local commentLine = P"//"*((P(1)-nl)^1)*nl
local commentBlock = P"/*" * ((P(1)-"*/")^1)*"*/"*wh
local comment = commentLine + commentBlock

local bit = S"#-" / function(str) return str=="#" and 1 or 0 end
local bitmap = Ct(Cc"bitmap" * Ct(Ct(sp * bit^1 * wh)^1))

local g = P({
 "prog",
 prog = wh* Ct(V'stmt'^0),
 stmt = (comment + codeTask + V'fn' + V'assign' + V'update'  + V'get')*wh,

 list = Ct(Cc"list" * P"[" * wh * argSep^-1 * Ct((V'stmt' * (P"," * wh * V'stmt')^0 * (wh*','*wh)^-1)^-1) * "]"),
 block = Ct(P"{"/"block" * blockParams * Ct((V'stmt')^0) * "}"),
 fn = Ct(Cc"fn" * fnParams * wh * V'stmt'), -- FIXME not needed? see block/lambda?

 value = (V'call'+V'block'+V'list'+num+bitmap),
 callArgs =  Ct(("(" * wh *( argSep^-1 * V'stmt' * (argSep * wh * V'stmt' )^0 * argSep^-1)^-1* ")")^-1 * sp * V'block'^-1 )*wh,
 get = Ct(Cc'get' * V'value' * V'callOnValue'),
 call  = Ct(Cc'call'*id * V'callArgs'),
 callOnValue  = ('.' * V'call' * V'callOnValue')^-1,

 var = Ct(Cc'var' * (V'value' * '.')^0 * id),
 assign = Ct(Cc"assign" * V'var' * ":" * wh * V'stmt'),
 update = Ct(Cc"update" * V'var' * "<<" * wh * V'stmt'),

})

return g;
