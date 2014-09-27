#To keep track only define units in base FFF or units defined below
#Accuracy is currently ~3s.f. so beware of error adding over multiple steps
#Be warned- ruby often does integer division and fucks things up
#TODO: some testing, these are probably horribly full of errors

$units=Hash.new

#general sillyness
$units['shed']={:name=>'shed',:value=>1e-24, :inUnits=>'b'}
$units['outhouse']={:name=>'outhouse',:value=>1e-6, :inUnits=>'b'}


$units['mph']={:name=>'Miles Per Hour',:value=>0.447, :inUnits=>'m s^-1'}

=begin
$units['']={:name=>'',:value=>, :inUnits=>''}
$units['']={:name=>'',:value=>, :inUnits=>''}
$units['']={:name=>'',:value=>, :inUnits=>''}
$units['']={:name=>'',:value=>, :inUnits=>''}
$units['']={:name=>'',:value=>, :inUnits=>''}
$units['']={:name=>'',:value=>, :inUnits=>''}
$units['']={:name=>'',:value=>, :inUnits=>''}
$units['']={:name=>'',:value=>, :inUnits=>''}
$units['fl.oz']={:name=>'fluid ounce',:value=>, :inUnits=>''}
=end

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
$units['bar']={:name=>'barometric pressure',:value=>1e5, :inUnits=>'Pa'}
$units['b']={:name=>'barn',:value=>1e-28, :inUnits=>'m^2'}
$units['me']={:name=>'electron mass',:value=>9.11e-31, :inUnits=>'kg'}
$units['hbar']={:name=>'reduced Planck constant',:value=>1.05e-34, :inUnits=>'J s'}
$units['h']={:name=>'Planck constant',:value=>6.63, :inUnits=>'J s'}
$units['c']={:name=>'speed of light in vacuum',:value=>3e8, :inUnits=>'m s^-1'}
$units['au']={:name=>'astronomical unit',:value=>1.50e11, :inUnits=>'m'}
$units['u']={:name=>'atomic mass unit',:value=>1.66e-27, :inUnits=>'kg'}
$units['t']={:name=>'tonne',:value=>1e3, :inUnits=>'kg'}
$units['l']={:name=>'litre',:value=>1e-3, :inUnits=>'m^3'}
$units['ha']={:name=>'hectare',:value=>1e4, :inUnits=>'m^2'}
$units['d']={:name=>'day',:value=>24, :inUnits=>'h'}
$units['h']={:name=>'hour',:value=>60, :inUnits=>'min'}
$units['min']={:name=>'minute',:value=>60, :inUnits=>'s'}

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
