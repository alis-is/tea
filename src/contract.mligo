#include "types.mligo"

// actions
#include "core/actions.mligo"

// onchain views
#include "views/lock.mligo"
#include "views/state.mligo"

let main(action: action_type) (store: storage_type): return_type =
  match action with
    Increment n -> add (n, store)
  | Decrement n -> sub (n, store)
  | SetLock l -> set_lock(l, store)
  | Default -> ([]: operation list), store

let generate_initial_storage(admin, about: address * bytes): storage_type = 
  let metadata = (Big_map.empty: contract_metadata_type) in
  let metadata: contract_metadata_type = Big_map.update ("") (Some(Bytes.pack("tezos-storage:content"))) metadata in
  let metadata = Big_map.update ("content") (Some(about)) metadata in
  { state = 0; admin = admin; locked = true; metadata = metadata }

