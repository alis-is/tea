#import "../src/contract.mligo" "Contract"
type param = Contract.C parameter_of

let test_deploy =
	let initial_storage = Contract.C.generate_initial_storage (("tz1aSkwEot3L2kmUvcoxzjMomb9mvBNuzFK6": address), 0x00) in
	let { code = _ ; size = _; taddr } = Test.Next.Originate.contract (contract_of Contract.C) initial_storage 0tez in
	let storage = Test.Next.get_storage taddr in
	assert (storage.admin = initial_storage.admin && storage.state = initial_storage.state && storage.locked = initial_storage.locked)

let test_add_locked_admin =
	let addr = Test.Next.Account.alice () in
	let _ = Test.Next.State.set_source addr in
	let initial_storage = Contract.C.generate_initial_storage (addr, 0x00) in
	let { code = _ ; size = _; taddr } = Test.Next.Originate.contract (contract_of Contract.C) initial_storage 0tez in
	let _ = Test.Next.Typed_address.transfer_exn taddr  (Increment (1)) 0mutez in
	let storage = Test.Next.get_storage taddr in
	assert (storage.state = initial_storage.state + 1)

let test_add_unlocked_admin =
	let addr = Test.Next.Account.alice () in
	let _ = Test.Next.State.set_source addr in
	let initial_storage = Contract.C.generate_initial_storage (addr, 0x00) in
	let { code = _ ; size = _; taddr } = Test.Next.Originate.contract (contract_of Contract.C) initial_storage 0tez in
	let _ = Test.Next.Typed_address.transfer_exn taddr (Set_lock (false)) 0mutez in
	let _ = Test.Next.Typed_address.transfer_exn taddr  (Increment (1)) 0mutez in
	let storage = Test.get_storage taddr in
	assert (storage.state = initial_storage.state + 1)