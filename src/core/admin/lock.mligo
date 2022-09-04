let set_lock (lockState, store: bool * storage_type): return_type = 
	let _assert = assert_admin(store) in
	([]: operation list), { store with locked = lockState }