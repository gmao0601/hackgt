#coefficient of drag

def drag_coefficient(D, rho, v, A):
  #D = drag
  #rho = density of air(so this changes)
  #v = velocity 
  #A = surface area of rocket
  #Cd = drag coeffient
  
  Cd = D / (a * .5 * rho * v^2)
  return Cd
