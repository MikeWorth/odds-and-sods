#To keep track only define units in base FFF or units defined below
#Accuracy is currently ~3s.f. so beware of error adding over multiple steps
#Be warned- ruby often does integer division and fucks things up
#TODO: some testing, these are probably horribly full of errors
#TODO: add in other dimensions like temperature (will need to alter FFF convertor.rb too)

$units=Hash.new

#common aliases
$units['mph']={:name=>'Miles Per Hour',:value=>1, :inUnits=>'mi h^-1'}
$units['lightyear']={:name=>'Light Year',:value=>1, :inUnits=>'c yr'}


#general sillyness
#length
$units['beard-second']={:name=>'beard second',:value=>10e-9, :inUnits=>'m'}
$units['sheppy']={:name=>'sheppy',:value=>7.0/8, :inUnits=>'mi'}
$units['smoot']={:name=>'smoot',:value=>1.7, :inUnits=>'m'}
#area
$units['shed']={:name=>'shed',:value=>1e-24, :inUnits=>'b'}
$units['outhouse']={:name=>'outhouse',:value=>1e-6, :inUnits=>'b'}

#assorted others
$units['CD']={:name=>'carat',:value=>0.2, :inUnits=>'g'}
$units['BTU']={:name=>'British thermal unit',:value=>1055, :inUnits=>'J'}
$units['oz.cu']={:name=>'ounces of copper per square foot',:value=>34.8e-6, :inUnits=>'m'}
#calorie



#colonial nonsense
$units['US.ton']={:name=>'short ton',:value=>20, :inUnits=>'US.cwt'}
$units['US.cwt']={:name=>'silly colonial hundredweight',:value=>100, :inUnits=>'lb'}
$units['US.pt']={:name=>'silly colonial pint',:value=>16, :inUnits=>'fl.oz'}
$units['US.qt']={:name=>'silly colonial quart',:value=>2, :inUnits=>'US.pt'}
$units['US.gal']={:name=>'silly colonial gallon',:value=>4, :inUnits=>'US.qt'}

#imperial
#mass
$units['pennyweight']={:name=>'pennyweight',:value=>24, :inUnits=>'gr'}
$units['tr.lb']={:name=>'troy pount',:value=>12, :inUnits=>'tr.oz'}
$units['tr.oz']={:name=>'troy ounce',:value=>480, :inUnits=>'gr'}
$units['ton']={:name=>'long ton',:value=>20, :inUnits=>'cwt'}
$units['cwt']={:name=>'hundredweight',:value=>112, :inUnits=>'lb'}
$units['st']={:name=>'stone',:value=>14, :inUnits=>'lb'}
$units['sc']={:name=>'scruple',:value=>20, :inUnits=>'gr'}
$units['gr']={:name=>'grain',:value=>1.0/7000, :inUnits=>'lb'}
$units['dr']={:name=>'drachm',:value=>1.0/16, :inUnits=>'oz'}
$units['oz']={:name=>'ounce',:value=>1.0/16, :inUnits=>'lb'}
$units['lb']={:name=>'pound',:value=>1.0/90, :inUnits=>'fir.mass'}
#volume
$units['tun']={:name=>'tun',:value=>2, :inUnits=>'butt'}
$units['butt']={:name=>'butt',:value=>3, :inUnits=>'barrel'}
$units['hogshead']={:name=>'hogshead',:value=>3, :inUnits=>'kilderkin'}
$units['barrel']={:name=>'barrel (ale)',:value=>4, :inUnits=>'fir'}
$units['kilderkin']={:name=>'kilderkin',:value=>2, :inUnits=>'fir'}
$units['pin']={:name=>'pin',:value=>0.5, :inUnits=>'fir'}
$units['fir']={:name=>'firkin (volume)',:value=>9, :inUnits=>'gal'}
$units['minim']={:name=>'minim',:value=>1.0/20, :inUnits=>'fl.s'}
$units['fl.sc']={:name=>'fluid scruple',:value=>1.0/3, :inUnits=>'fl.dr'}
$units['fl.dr']={:name=>'fluid drachm',:value=>1.0/8, :inUnits=>'fl.oz'}
$units['gal']={:name=>'gallon',:value=>4, :inUnits=>'qt'}
$units['qt']={:name=>'quart',:value=>2, :inUnits=>'pt'}
$units['pt']={:name=>'pint',:value=>20, :inUnits=>'fl.oz'}
$units['gi']={:name=>'gill',:value=>5, :inUnits=>'fl.oz'}
$units['fl.oz']={:name=>'fluid ounce',:value=>3.633e-12, :inUnits=>'fur^3'}
#area
$units['ac']={:name=>'acre',:value=>1, :inUnits=>'fur ch'}
$units['rood']={:name=>'rood',:value=>1, :inUnits=>'fur rod'}
$units['perch']={:name=>'perch',:value=>1, :inUnits=>'rod^2'}
#length
$units['hand']={:name=>'hand',:value=>4, :inUnits=>'in'}
$units['link']={:name=>'link',:value=>0.04, :inUnits=>'rod'}
$units['rod']={:name=>'rod',:value=>0.25, :inUnits=>'ch'}
$units['barleycorn']={:name=>'barleycorn',:value=>1/3, :inUnits=>'in'}
$units['nmi']={:name=>'nautical mile',:value=>1e3, :inUnits=>'ftm'}
$units['ftm']={:name=>'fathom',:value=>2, :inUnits=>'yd'}
$units['lea']={:name=>'league',:value=>3, :inUnits=>'mi'}
$units['mi']={:name=>'mile',:value=>8, :inUnits=>'fur'}
$units['in']={:name=>'inch',:value=>1.0/12, :inUnits=>'ft'}
$units['ft']={:name=>'foot',:value=>1.0/3, :inUnits=>'yd'}
$units['yd']={:name=>'yard',:value=>1.0/22, :inUnits=>'ch'}
$units['ch']={:name=>'chain',:value=>0.1, :inUnits=>'fur'}

#non-SI but common in science
#parsec
$units['St']={:name=>'Stokes',:value=>1e-4, :inUnits=>'m^2 s^-1'}
$units['P']={:name=>'Poise',:value=>0.1, :inUnits=>'Pa s'}
$units['eV']={:name=>'electron Volt',:value=>1.60e-19, :inUnits=>'J'}
$units['bar']={:name=>'barometric pressure',:value=>1e5, :inUnits=>'Pa'}
$units['b']={:name=>'barn',:value=>1e-28, :inUnits=>'m^2'}
$units['me']={:name=>'electron mass',:value=>9.11e-31, :inUnits=>'kg'}
$units['hbar']={:name=>'reduced Planck constant',:value=>1.05e-34, :inUnits=>'J s'}
$units['c']={:name=>'speed of light in vacuum',:value=>3e8, :inUnits=>'m s^-1'}
$units['au']={:name=>'astronomical unit',:value=>1.50e11, :inUnits=>'m'}
$units['u']={:name=>'atomic mass unit',:value=>1.66e-27, :inUnits=>'kg'}
$units['t']={:name=>'tonne',:value=>1e3, :inUnits=>'kg'}
$units['l']={:name=>'litre',:value=>1e-3, :inUnits=>'m^3'}
$units['ha']={:name=>'hectare',:value=>1e4, :inUnits=>'m^2'}
$units['yr']={:name=>'year',:value=>365.25, :inUnits=>'d'}
$units['wk']={:name=>'week',:value=>7, :inUnits=>'d'}
$units['d']={:name=>'day',:value=>24, :inUnits=>'h'}
$units['h']={:name=>'hour',:value=>60, :inUnits=>'min'}
$units['min']={:name=>'minute',:value=>60, :inUnits=>'s'}
$units['g']={:name=>'gram',:value=>1e-3, :inUnits=>'kg'}

#SI Derived
$units['W']={:name=>'Watt',:value=>1, :inUnits=>'J s^-1'}
$units['J']={:name=>'Joule',:value=>1, :inUnits=>'N m'}
$units['Pa']={:name=>'Pascal',:value=>1, :inUnits=>'N m^-2'}
$units['N']={:name=>'Newton',:value=>1, :inUnits=>'kg m s^-2'}
$units['Hz']={:name=>'Hertz',:value=>1, :inUnits=>'s^-1'}

#SI base
$units['kg']={:name=>'kilogram',:value=>245e-4, :inUnits=>'fir.mass'}
$units['s']={:name=>'Seconds',:value=>8.267e-7, :inUnits=>'ftn'}
$units['m']={:name=>'metre', :value=>0.004971, :inUnits=>'fur'}

#FFF base
$units['fur']={:name=>'furlong'}
$units['fir.mass']={:name=>'firkin mass'}
$units['ftn']={:name=>'fortnight'}

$baseUnits=['fir.mass','fur','ftn']

puts "unit definitions loaded"
