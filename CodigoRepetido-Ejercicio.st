!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:51:15'!
assertIf: customerBook HaveThisNumberOfActiveCustomers: numberOfActiveCustomers ThisNumberOfSuspendedCustomers: numberOfsuspendedCustomers ThisNumberOfTotalCustomers: numberOfTotalCustomers andShouldHavePaulMcCartney: aBoolean  
	self assert: numberOfTotalCustomers  equals: customerBook numberOfCustomers.
	self assert:( (customerBook includesCustomerNamed: 'Paul McCartney' ) xor:  aBoolean not). 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:51:46'!
assertIfOnlyCustomerIsJohnLennon: customerBook
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: 'John Lennon')! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:53:13'!
assertIfOnlyCustomerIsJohnLennonOf: customerBook onCantSuspendWhenSuspendedCustomerIs: customerName

	^ [ customerBook suspendCustomerNamed: customerName.
	self fail ]
		on: CantSuspend 
		do: [ :anError | self assertIfOnlyCustomerIsJohnLennon: customerBook ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:52:54'!
createACostumerBookAndSuspend:customerName
	customerBook suspendCustomerNamed: aCostumer.
	^customerBook
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:52:40'!
createCustomerBookWith:customerName


! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 10:27:01'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook   |
	customerBook := CustomerBook new.

	self thisColaboration:  [	customerBook addCustomerNamed: 'John Lennon'.]  shouldNotTakeMoreThan: 50*millisecond	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 10:13:49'!
test01AddingCustomerShouldNotTakeMoreThan50MillisecondsCopy

	| customerBook millisecondsBeforeRunning millisecondsAfterRunning |
	
	customerBook := CustomerBook new.
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	customerBook addCustomerNamed: 'John Lennon'.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:35:14'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook   paulMcCartney |
	self thisColaboration: 	[customerBook removeCustomerNamed: paulMcCartney. ] shouldNotTakeMoreThan: 100*millisecond 

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 10:13:42'!
test02RemovingCustomerShouldNotTakeMoreThan100MillisecondsCopy

	| customerBook millisecondsBeforeRunning millisecondsAfterRunning paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	customerBook removeCustomerNamed: paulMcCartney.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:35:31'!
test03CanNotAddACustomerWithEmptyName 
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 11:57:17'!
test03CanNotAddACustomerWithEmptyNameCopy 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:33:05'!
test04CanNotRemoveAnInvalidCustomer
	[ customerBook removeCustomerNamed: 'Paul McCartney'. self fail ] on: NotFound		do: [ :anError |			self assertIfOnlyCustomerIsJohnLennon: customerBook ]

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 11:57:30'!
test04CanNotRemoveAnInvalidCustomerCopy
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:42:59'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 10:37:18'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBookCopy

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:43:32'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	self assertIf: customerBook HaveThisNumberOfActiveCustomers: 0  ThisNumberOfSuspendedCustomers: 0  ThisNumberOfTotalCustomers:0   andShouldHavePaulMcCartney: false 

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 10:37:26'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBookCopy

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:44:34'!
test07CanNotSuspendAnInvalidCustomer
	customerBook := self  createCustomerBookWith: 'John Lennon'. 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 12:07:01'!
test07CanNotSuspendAnInvalidCustomerCopy
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'George Harrison'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:46:04'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	johnLennon := 'John Lennon'.
	customerBook := self  createACostumerBookAndSuspend: johnLennon .
	self assertIfOnlyCustomerIsJohnLennonOf: customerBook onCantSuspendWhenSuspendedCustomerIs: johnLennon
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 12:29:19'!
test08CanNotSuspendAnAlreadySuspendedCustomerCopy
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 10:27:01'!
thisColaboration: aBlock shouldNotTakeMoreThan: time

	|  millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (time)
	
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'jb 4/12/2023 13:56:16'!
numberOfCustomers

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'jb 4/12/2023 13:59:58'!
removeCustomerNamed: aName 
	active remove: aName ifAbsent: [suspended  remove: aName ifAbsent:[	^ NotFound signal.] ]
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'jb 4/12/2023 14:00:45'!
suspendCustomerNamed: aName 
	active remove: aName.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !