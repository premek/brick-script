local lpeg = require "lpeg"
local inspect = require 'inspect'


lpeg.locale(lpeg)
local S,C,Ct,Cc,Cg,Cb,Cf,Cmt,Cp,P,V =
  lpeg.S, lpeg.C, lpeg.Ct, lpeg.Cc, lpeg.Cg, lpeg.Cb, lpeg.Cf, lpeg.Cmt, lpeg.Cp,
  lpeg.P, lpeg.V


local eof = -1
local sp = S" \t" ^0 + eof
local wh = S" \t\r\n" ^0 + eof
local nl = S"\r\n" ^1 + eof

local symbols = S":{}(),. \t\r\n"

local id = C((P(1)-symbols)^1)*sp
local ident = id *(wh*'.'*wh* id)^0 * sp
local name = Ct(Cc"name" * ident)
local num = Ct(Cc"num" * C(lpeg.digit^1)) *sp -- do we really need you? :)
local params = Ct(Cc"params" * id * (P"," * wh * id)^0) *sp

local commentLine = P"//"*((P(1)-nl)^1)*nl
local commentBlock = P"/*" * ((P(1)-"*/")^1)*"*/"*wh
local comment = commentLine + commentBlock

local bit = S"#-" / function(str) return str=="#" and 1 or 0 end
local bitmap = Ct(Cc"bitmap" * Ct(Ct(sp * bit^1 * wh)^1))

local g = P({
 "prog",
 prog = wh* Ct(V'stmt'^1),
 stmt = (comment + V'block' + V'call' + V'assign' + V'update' +  V'list' + bitmap + num + name)*wh,

 list = Ct(Cc"list" * P"[" * wh * V'stmt' * (P"," * wh * V'stmt')^0 * "]"),
 block = Ct(P"{"/"block" * wh * ((V'stmt')^0) * "}"),
 assign = Ct(Cc"assign" * ident * params^0 * ":" * wh * V'stmt'),
 update = Ct(Cc"update" * ident * wh*"<<" * wh * V'stmt'),

 call = Ct(Cc"call" * name * wh *"(" * wh * V'stmt'^-1 * ("," * wh * V'stmt'^-1 ) ^-1 * ")"),


})


print(inspect(g:match([[

bricks : [
##
##
,
#
#
#
#
,
-#
##
#-
]

brick
brickPos

newBrick : {
  brick << next
  next << new
  brickPos << [3, 0]
}


}, {
  {X},
  {X},
  {X},
  {X},
}, {
  {_,X},
  {X,X},
  {X,_},
},
}




print(###,-)

lives:
#
#
#
#

die:
  lives << lives.tail()


loop: {
  next.draw(lives)
}

> : di-e


  -###-
  #---#
  #---#
  -####
  ----#
  #---#
  -###-





]])));
