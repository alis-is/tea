#include "util/assert.mligo"
#include "admin/lock.mligo"
#include "common/increment.mligo"
#include "common/decrement.mligo"

type action_type = 
	Increment of int
  | Decrement of int
  | SetLock of bool
  | [@annot:def] Default