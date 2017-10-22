defmodule Monerox.Wallet do
  @moduledoc """
  `Monerox.Wallet` interact with the Monero Wallet RPC daemon. Here the list of
  the available calls

    ## RPC
      * getbalance/0
      * getaddress/0
      * getheight/0

    TODO:
      * transfer
      * transfer_split
      * sweep_dust
      * sweep_all
      * store
      * get_payments
      * get_bulk_payments
      * get_transfers
      * get_transfer_by_txid
      * incoming_transfers
      * query_key
      * make_integrated_address
      * split_integrated_address
      * stop_wallet
      * make_uri
      * parse_uri
      * rescan_blockchain
      * set_tx_notes
      * get_tx_notes
      * sign
      * verify
      * export_key_images
      * import_key_images
      * get_address_book
      * add_address_book
      * delete_address_book
      * rescan_spent
      * start_mining
      * stop_mining
      * get_languages
      * create_wallet
      * open_wallet
  """

  @doc """
  Return the balance of the wallet.

  ## Params

    None

  ## Example:

    iex> Monerox.Wallet.getbalance()
    %{id: "0", jsonrpc: "2.0", result: %{balance: 0, unlocked_balance: 0}}
  """
  defdelegate getbalance(), to: Monerox.Wallet.RPC

  @doc """
  Return the balance of the wallet.

  ## Params

    None

  ## Example:

    iex> Monerox.Wallet.getaddress()
    %{id: "0", jsonrpc: "2.0",
    result: %{address: "46oyeHRG..."}}
  """
  defdelegate getaddress(), to: Monerox.Wallet.RPC

  @doc """
  Return the height of the current block of the wallet.

  ## Params

    None

  ## Example:

    iex> Monerox.Wallet.getheight()
    %{id: "0", jsonrpc: "2.0", result: %{height: 1421114}}
  """
  defdelegate getheight(), to: Monerox.Wallet.RPC

end
