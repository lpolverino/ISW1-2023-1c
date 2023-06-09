!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'emptyPortfolio accountWith100DepositRegister depositOf100InAccount portfolioWith100DepositAccount portfolioWithPortfolioWith100DepositAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'expect' stamp: 'jb 5/22/2023 16:51:05'!
expectForAPortafolioWithAnAccountAndBalance100AfterAdding: aBlock ThisBalance: aExpectedBalance
aBlock  value: portfolioWith100DepositAccount .
self assert:aExpectedBalance equals: portfolioWith100DepositAccount balance.! !

!PortfolioTest methodsFor: 'expect' stamp: 'jb 5/22/2023 16:51:27'!
expectForAPortfolioWithBalanceOf100AfterDoing: aBlock ThisBalance: expectedBalance

aBlock  value:portfolioWithPortfolioWith100DepositAccount .
self assert:expectedBalance equals: portfolioWithPortfolioWith100DepositAccount balance.! !


!PortfolioTest methodsFor: 'error auxiliar' stamp: 'lp 5/22/2023 13:41:00'!
shouldFailWhenAdding: portfolio toPortfolio: portfolioToAdd

	^ self should: [portfolioToAdd add: portfolio ]
	 raise: Error 
	 withExceptionDo:[:anError|
		self assert:( anError messageText) equals:( Portfolio cannotAddAlreadyExistingAccount) ]! !

!PortfolioTest methodsFor: 'error auxiliar' stamp: 'lp 5/22/2023 15:23:58'!
shouldFailWhenAddingAnAccountToAPorfolioWhoHasAAcestorAndAlsoIsPredecesorTo: aBlock
| portfolioRoot      portfolioFather  portfolioChild account |portfolioRoot  := Portfolio new. 
 
portfolioFather  := Portfolio  new.
portfolioChild := Portfolio new  .

account := ReceptiveAccount new.Deposit register: 100 on: account.

portfolioRoot add:account.
aBlock value: portfolioFather .
portfolioRoot  add: portfolioFather . 
portfolioFather  add: portfolioChild . 


self shouldFailWhenAdding: account toPortfolio: portfolioChild .
	
	
	


! !

!PortfolioTest methodsFor: 'error auxiliar' stamp: 'lp 5/22/2023 15:24:17'!
shouldFailWhenAddingAnAccountToAPortfolioWhoHasAnPortfolioWithTheSameAccountAndAlsoIsChildOf: aBlock
|portfolioFather portfolioChild account |portfolioFather  := Portfolio  new.
portfolioChild := Portfolio new  .

account := ReceptiveAccount new.Deposit register: 100 on: account.
aBlock value: portfolioChild .
portfolioFather  add:account.portfolioFather add: portfolioChild  . 


self shouldFailWhenAdding: account toPortfolio: portfolioChild .
	


! !


!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/22/2023 16:37:44'!
createAPortfolioWith100DepositAccount

	^ Portfolio new add: portfolioWith100DepositAccount! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'lp 5/22/2023 15:01:35'!
test00PortofolioShouldStartWithBalanceIn0

|portfolio|
portfolio := Portfolio new.
self assert:0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'lp 5/22/2023 16:01:33'!
test01addFirstAccountMakePortfolioBalanceEqualsToTheAccountBalance
self expectForAPortafolioWithAnAccountAndBalance100AfterAdding: [:nothing|] ThisBalance: 100.! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'lp 5/22/2023 16:01:33'!
test02addAccountSHouldAddHisBalanceself expectForAPortafolioWithAnAccountAndBalance100AfterAdding:[:portfolio ||anotherAccount |
anotherAccount := ReceptiveAccount new.
Deposit register: 50 on: anotherAccount .
portfolio add: anotherAccount .
] ThisBalance: 150
! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'lp 5/22/2023 16:02:18'!
test03addFirstAPortafolioMakeTheBalanceEqualsToTheAddedPoratafolioBalance
self expectForAPortfolioWithBalanceOf100AfterDoing:  [:nothing]ThisBalance: 100.
! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'lp 5/22/2023 16:02:18'!
test04addAPortafolioSHouldAddHisBalance
self expectForAPortfolioWithBalanceOf100AfterDoing:[:portfolio|
	|secondPortafolioToAdd secondAccount|
	
secondPortafolioToAdd := Portfolio new initialize .
secondAccount := ReceptiveAccount new.
Deposit register: 100 on: secondAccount.
secondPortafolioToAdd add: secondAccount.
portfolio add: secondPortafolioToAdd .
]  ThisBalance: 200.
! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/22/2023 16:33:17'!
test05addAAccountAlreadyInThePortfolioAccountsProducesError
self shouldFailWhenAdding: accountWith100DepositRegister toPortfolio: portfolioWith100DepositAccount .
! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/22/2023 16:34:06'!
test06addAAccountAlreadyInThePortfolioInnerPortafolioProducesError
|portfolio |
portfolio := Portfolio new initialize.
portfolio add: portfolioWith100DepositAccount .
self shouldFailWhenAdding: accountWith100DepositRegister toPortfolio: portfolio .
! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/22/2023 16:37:44'!
test07addAAccountAlreadyInThePortfolioInnerPortafoliosProducesError|portfolio |
portfolio := Portfolio new initialize.portfolio add: (self createAPortfolioWith100DepositAccount ) .self shouldFailWhenAdding: accountWith100DepositRegister toPortfolio: portfolio .
! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/22/2023 16:38:29'!
test08addAPortafolioWIthAAlreadyExistingAccountInTheReceptorPortfolioAccounts
self shouldFailWhenAdding: (self createAPortfolioWith100DepositAccount )  toPortfolio: portfolioWith100DepositAccount .

! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/22/2023 16:43:57'!
test09addAPortafolioWIthAAlreadyExistingAccountInThePortfolioReceptorInmeidatePortfolios
self shouldFailWhenAdding: portfolioWith100DepositAccount toPortfolio: portfolioWithPortfolioWith100DepositAccount .

! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/22/2023 16:46:13'!
test10addAPortafolioWIthAAlreadyExistingAccountInThePortfolioReceptorInnerPortfolios
|portfolio portfolioToAdd |
portfolio := Portfolio new add: portfolioWithPortfolioWith100DepositAccount .
portfolioToAdd  := self createAPortfolioWith100DepositAccount  .
self shouldFailWhenAdding: portfolioToAdd toPortfolio: portfolio .
! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'lp 5/22/2023 15:24:17'!
test13cannotAddAnAccounttoAPortfolioWhenThereIsAnotherPortfolioWhoHasAddedTheAccountAndThePortfolio
self shouldFailWhenAddingAnAccountToAPortfolioWhoHasAnPortfolioWithTheSameAccountAndAlsoIsChildOf:[:nothing]


! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/22/2023 16:46:59'!
test14cannotAddAnAccounttoAPortfolioWhenThereAreManyPortfoliosWhoHasAddedThePortfolioAndOneHasTheAccount
self shouldFailWhenAddingAnAccountToAPortfolioWhoHasAnPortfolioWithTheSameAccountAndAlsoIsChildOf:[:portfolioChild |
	|portfolioFather|	portfolioFather  := Portfolio  new.	portfolioFather add: portfolioChild ]
	


! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'lp 5/22/2023 15:23:59'!
test15cannotAddAnAccounttoAPortfolioWhenThereIsAnotherPortfolioWhoHasTheAccountAndThePortfolio
self shouldFailWhenAddingAnAccountToAPorfolioWhoHasAAcestorAndAlsoIsPredecesorTo:[:nothing].
	
	
	


! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'lp 5/22/2023 15:23:59'!
test16cannotAddAnAccounttoAPortfolioWhenThereAreManyPortfoliosWhoHaveTheAccountAndThePortfolio


self shouldFailWhenAddingAnAccountToAPorfolioWhoHasAAcestorAndAlsoIsPredecesorTo:[:portfolioAdded |
	|anotherPortfolioRoot|
	anotherPortfolioRoot  := Portfolio new. 
	anotherPortfolioRoot  add: portfolioAdded .

	]
	
	


! !


!PortfolioTest methodsFor: 'hasRegisteredTest' stamp: 'jb 5/22/2023 16:47:56'!
test11hasRegisterInAddedAccount

self assert: ( portfolioWithPortfolioWith100DepositAccount  hasRegistered: depositOf100InAccount )! !

!PortfolioTest methodsFor: 'hasRegisteredTest' stamp: 'jb 5/22/2023 16:49:05'!
test12hasRegisterNotInAddedAccount|register|

register :=  Withdraw  register:  50  on:  ReceptiveAccount  new.

self deny: ( portfolioWith100DepositAccount  hasRegistered: register )! !

!PortfolioTest methodsFor: 'hasRegisteredTest' stamp: 'jb 5/22/2023 16:49:32'!
test19hasRegisterInAddedPortfolio
self assert: ( portfolioWithPortfolioWith100DepositAccount  hasRegistered: depositOf100InAccount )! !


!PortfolioTest methodsFor: 'transaction' stamp: 'jb 5/22/2023 16:49:56'!
test17transactionsOfAddedAccounts


self assert: (OrderedCollection   with: depositOf100InAccount  )equals: portfolioWith100DepositAccount transactions .
! !

!PortfolioTest methodsFor: 'transaction' stamp: 'jb 5/22/2023 16:50:26'!
test20transactionsOfAddedPortfolioself assert: (OrderedCollection   with: depositOf100InAccount  )equals: portfolioWithPortfolioWith100DepositAccount transactions .! !


!PortfolioTest methodsFor: 'setUp' stamp: 'jb 5/22/2023 16:42:39'!
setUp
	emptyPortfolio :=  Portfolio new.
	accountWith100DepositRegister := ReceptiveAccount  new. 
	depositOf100InAccount := Deposit  register: 100  on: accountWith100DepositRegister.
	portfolioWith100DepositAccount := (Portfolio new ) add: accountWith100DepositRegister. 
	portfolioWithPortfolioWith100DepositAccount  := Portfolio  new add: portfolioWith100DepositAccount .! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'lp 5/18/2023 12:42:36'!
affetBalance: aBalance 
	^aBalance + self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'lp 5/18/2023 12:42:58'!
affetBalance: aBalance 
	^aBalance - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialElement category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialElement methodsFor: 'balance' stamp: 'jb 5/20/2023 20:23:41'!
balance
	self  subclassResponsibility ! !


!FinancialElement methodsFor: 'transactions' stamp: 'jb 5/20/2023 20:23:46'!
transactions
	self  subclassResponsibility ! !


!FinancialElement methodsFor: 'testing' stamp: 'jb 5/20/2023 20:23:34'!
hasRegistered: aRegister
	self  subclassResponsibility ! !


!FinancialElement methodsFor: 'addig private' stamp: 'jb 5/21/2023 16:39:14'!
doesItHaveAnAccountInCommonWith: aFinancialElement
	self  subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialElement subclass: #Portfolio
	instanceVariableNames: 'financialElements portfolioHirarchy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'adding' stamp: 'jb 5/21/2023 23:52:22'!
add: aFinancialElementToAdd 
		self checkIfItCanAddThisFinancialElement:  aFinancialElementToAdd . 
		financialElements  add: aFinancialElementToAdd. 
		aFinancialElementToAdd addToPortfoliosInTheHirarchy: self.  ! !


!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 23:52:22'!
addToPortfoliosInTheHirarchy: aPortfolio 

	portfolioHirarchy  := portfolioHirarchy add: aPortfolio ! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 23:57:29'!
checkIfItCanAddThisFinancialElement: aFinancialElementToAdd
	(portfolioHirarchy  doesAnyElementInHirarchyHaveAnAccountInCommonWith: aFinancialElementToAdd ) ifTrue:  [
			self error: self class cannotAddAlreadyExistingAccount 
		]
	
	! !

!Portfolio methodsFor: 'adding private' stamp: 'lp 5/22/2023 14:26:39'!
doesAnyOfItsElementsHasAnAccountInCommonWith: aFinancialElementToAdd 
		
		^ self doesAnyOfItsElementsof: financialElements HasAnAccountInCommonWith: aFinancialElementToAdd 

	
	
	
		! !

!Portfolio methodsFor: 'adding private' stamp: 'lp 5/22/2023 14:27:08'!
doesAnyOfItsElementsHasAnAccountInCommonWith: aFinancialElementToAdd  notStoppingBy: aPortfolioToAvoid 
		^ self doesAnyOfItsElementsof: (self financialElementsWithout: aPortfolioToAvoid ) HasAnAccountInCommonWith:  aPortfolioToAvoid 
		! !

!Portfolio methodsFor: 'adding private' stamp: 'lp 5/22/2023 14:26:03'!
doesAnyOfItsElementsof: aFinancialElementsCollection HasAnAccountInCommonWith: aFinancialElementToAdd 
		
		^ aFinancialElementsCollection  anySatisfy:[:aFinancialElement|
			  aFinancialElementToAdd sharesAnAccountWith: aFinancialElement 
		].
	
	
	
		! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:32:01'!
doesItHaveAnAccountInCommonWith: aPortfolio 
	^self doesAnyOfItsElementsHasAnAccountInCommonWith:  aPortfolio .! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 17:49:07'!
financialElementsWithout: aPortfolioToAvoid

	^ financialElements  reject:  [:aFinancialElement |
				aFinancialElement  = aPortfolioToAvoid  
			]! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:24:21'!
hasOrIsThisAccount: anAccount
	^financialElements  anySatisfy: [:aFinancialElement|
		aFinancialElement  hasOrIsThisAccount:  anAccount 
		]! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/22/2023 00:03:42'!
roots
	
	^portfolioHirarchy allRoots.  ! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:34:08'!
sharesAnAccountWith: aFinancialElement 
	 ^aFinancialElement  doesItHaveAnAccountInCommonWith: self.! !


!Portfolio methodsFor: 'balance' stamp: 'jb 5/20/2023 20:24:52'!
balance
	^ financialElements sum:[:aFinancialElement | aFinancialElement  balance] ifEmpty: [0] ! !


!Portfolio methodsFor: 'initialization' stamp: 'jb 5/21/2023 23:51:00'!
initialize
financialElements  := OrderedCollection new. 
	

portfolioHirarchy  := PortfolioHirarchy of: self. ! !


!Portfolio methodsFor: 'register' stamp: 'jb 5/22/2023 12:42:26'!
hasRegistered: aRegister 
	^financialElements  anySatisfy:  [:aFinancialElement|
		aFinancialElement hasRegistered:  aRegister 
		]! !


!Portfolio methodsFor: 'transactions' stamp: 'jb 5/22/2023 12:53:51'!
transactions
	|transactions|
	transactions := OrderedCollection  new. 
	financialElements  do: [:aFinancialElement|
		transactions  addAll:  aFinancialElement  transactions			
	].
	^transactions ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 13:24:59'!
cannotAddAlreadyExistingAccount
^'The Account is Already in the Portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialElement subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'lp 5/18/2023 12:41:48'!
balance

	^transactions inject:0 into:[:aBalance :aTransaction | aTransaction affetBalance: aBalance ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'adding private' stamp: 'jb 5/21/2023 23:52:22'!
addToPortfoliosInTheHirarchy: aPortfolio ! !

!ReceptiveAccount methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:34:46'!
doesItHaveAnAccountInCommonWith: aFinancialElement 
	^aFinancialElement  hasOrIsThisAccount:  self.! !

!ReceptiveAccount methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:24:21'!
hasOrIsThisAccount: anAccount 
	^self = anAccount  ! !

!ReceptiveAccount methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:34:08'!
sharesAnAccountWith: aFinancialElement 
	^aFinancialElement  hasOrIsThisAccount:  self.! !


!classDefinition: #PortfolioHirarchy category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioHirarchy
	instanceVariableNames: 'portfolioInTheCenterOfTheHirarchy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioHirarchy methodsFor: 'hirarchy' stamp: 'jb 5/21/2023 23:42:26'!
allRoots 
	self subclassResponsibility ! !

!PortfolioHirarchy methodsFor: 'hirarchy' stamp: 'jb 5/21/2023 23:57:52'!
doesAnyElementInHirarchyHaveAnAccountInCommonWith: aFinancialElementToAdd 
	self subclassResponsibility ! !


!PortfolioHirarchy methodsFor: 'adding' stamp: 'jb 5/22/2023 11:55:23'!
add:aPortfolioToAddInTheHirarchy
	self subclassResponsibility  ! !


!PortfolioHirarchy methodsFor: 'initializing' stamp: 'jb 5/22/2023 11:57:40'!
initializeWith: aPortfolio
	portfolioInTheCenterOfTheHirarchy  := aPortfolio ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioHirarchy class' category: 'Portfolio-Ejercicio'!
PortfolioHirarchy class
	instanceVariableNames: ''!

!PortfolioHirarchy class methodsFor: 'as yet unclassified' stamp: 'jb 5/21/2023 23:49:55'!
of: aPortfolioToStablishHirarchy
	^PortfolioRoot new initializeWith: aPortfolioToStablishHirarchy ! !


!classDefinition: #PortfolioBranched category: 'Portfolio-Ejercicio'!
PortfolioHirarchy subclass: #PortfolioBranched
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioBranched methodsFor: 'hirarchy' stamp: 'jb 5/22/2023 00:03:18'!
allRoots
	|collectionOfRoots|
	collectionOfRoots  := OrderedCollection  new. 
	parents  do: [:aParentPortfolio|
		collectionOfRoots  addAll:  aParentPortfolio  roots 
		].
	^collectionOfRoots ! !

!PortfolioBranched methodsFor: 'hirarchy' stamp: 'jb 5/22/2023 00:00:59'!
doesAnyElementInHirarchyHaveAnAccountInCommonWith: aFinancialElementToAdd 
	^self allRoots  anySatisfy: [:aPortfolioRoot|
		aPortfolioRoot  doesItHaveAnAccountInCommonWith:  aFinancialElementToAdd 
		]! !


!PortfolioBranched methodsFor: 'adding' stamp: 'jb 5/21/2023 23:49:07'!
add: aPortfolioToAddToHirarchy
	parents  add: aPortfolioToAddToHirarchy. 
	^self! !


!PortfolioBranched methodsFor: 'initializing' stamp: 'jb 5/22/2023 11:59:21'!
initializeWith: aPortfolioToMakeHirarchy  and: aPortfolioToBeginHirarchy
	parents := OrderedCollection  new. 
	parents  add: aPortfolioToBeginHirarchy .
	super initializeWith:  aPortfolioToMakeHirarchy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioBranched class' category: 'Portfolio-Ejercicio'!
PortfolioBranched class
	instanceVariableNames: ''!

!PortfolioBranched class methodsFor: 'as yet unclassified' stamp: 'jb 5/21/2023 23:39:04'!
of: aPortfolioToMakeHirarchy with: aPortfolioToBeginHirarchy 
	^ self new initializeWith: aPortfolioToMakeHirarchy  and: aPortfolioToBeginHirarchy  ! !


!classDefinition: #PortfolioRoot category: 'Portfolio-Ejercicio'!
PortfolioHirarchy subclass: #PortfolioRoot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioRoot methodsFor: 'hirarchy' stamp: 'jb 5/22/2023 11:58:37'!
allRoots 
	 ^OrderedCollection  with:  portfolioInTheCenterOfTheHirarchy ! !

!PortfolioRoot methodsFor: 'hirarchy' stamp: 'jb 5/22/2023 11:58:46'!
doesAnyElementInHirarchyHaveAnAccountInCommonWith: aFinancialElementToAdd 
	^portfolioInTheCenterOfTheHirarchy  doesAnyOfItsElementsHasAnAccountInCommonWith:  aFinancialElementToAdd ! !


!PortfolioRoot methodsFor: 'adding' stamp: 'jb 5/22/2023 11:58:19'!
add: aPortfolioUpInTheHirarchy
	^PortfolioBranched  of: portfolioInTheCenterOfTheHirarchy  with: aPortfolioUpInTheHirarchy 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioRoot class' category: 'Portfolio-Ejercicio'!
PortfolioRoot class
	instanceVariableNames: 'portfolio'!

!PortfolioRoot class methodsFor: 'as yet unclassified' stamp: 'jb 5/21/2023 23:45:01'!
of: aPortfolioToMakeHirarchy
	^self new initializeWith:  aPortfolioToMakeHirarchy ! !
