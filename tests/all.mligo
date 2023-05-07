#include "../src/contract.mligo"

let test_deploy =
	let initial_storage: storage_type = generate_initial_storage (("tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6": address), 0x00) in
	let taddr, _, _ = Test.originate main initial_storage 0tez in
	let storage = Test.get_storage taddr in
	assert (storage.admin = initial_storage.admin && storage.state = initial_storage.state && storage.locked = initial_storage.locked)

let test_add_locked_not_admin =
	let initial_storage: storage_type = generate_initial_storage (("tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6": address), 0x00) in
	let taddr, _, _ = Test.originate main initial_storage 0tez in
  	let contr = Test.to_contract taddr in
  	let result = Test.transfer_to_contract contr (Increment (1)) 0mutez in
	let txResult = match result with
		  Fail (v) -> v
		| Success (_v) -> failwith("should fail") in
	let _ = match txResult with 
		  Rejected (reason) ->
			assert((Test.to_string reason.0) = "\"not admin\"")
		| Balance_too_low(_e) -> failwith("should reject")
		| Other(_e) -> failwith("should reject") in
	let storage = Test.get_storage taddr in
  	assert (storage.state = initial_storage.state)

let test_add_locked_admin =
	let addr = Test.nth_bootstrap_account 0 in
	let initial_storage: storage_type = generate_initial_storage (addr, 0x00) in
	let _ = Test.set_source addr in
	let taddr, _, _ = Test.originate main initial_storage 0tez in
  	let contr = Test.to_contract taddr in
  	let _ = Test.transfer_to_contract_exn contr (Increment (1)) 0mutez in
	let storage = Test.get_storage taddr in
  	assert (storage.state = initial_storage.state + 1)

let test_add_unlocked_admin =
	let addr = Test.nth_bootstrap_account 0 in
	let initial_storage: storage_type = generate_initial_storage (addr, 0x00) in
	let _ = Test.set_source addr in
	let taddr, _, _ = Test.originate main initial_storage 0tez in
  	let contr = Test.to_contract taddr in
  	let _ = Test.transfer_to_contract_exn contr (SetLock (false)) 0mutez in
	let addr = Test.nth_bootstrap_account 1 in
	let _ = Test.set_source addr in
	let _ = Test.transfer_to_contract_exn contr (Increment (1)) 0mutez in
	let storage = Test.get_storage taddr in
  	assert (storage.state = initial_storage.state + 1)