let add (n, store: int * storage_type): return_type = 
	let _assert = assert_admin_or_not_locked(store) in
	([]: operation list), { store with state = store.state + n }