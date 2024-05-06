// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

    struct NodeInfo{
        //node address
        address node;
        //Staking total amount
        uint128 total;
    }

interface IStaking{

    /*
    @dev node infomation
    Returns 'node' true: candidates or electeds
    'total':   Staking total amount
    'elected':  true: be elected
    'authorId'
    */
    function getNodeInfo(address user)  external view returns(bool node, uint256 total, bool elected, bytes32 authorId);

    /* @dev  Returns electeds
    'node' node address
    'total' Staking total amount
    */
    function electeds() external view returns (NodeInfo[] memory nodes);

    /* @dev Returns candidates
    'node' node address
    'total' Staking total amount
    */
    function candidates() external view returns (NodeInfo[] memory nodes);

    /* @dev apple to be a candidate
     '_contract'�� node 's contract
     'amount'��Staking `amount` of GPs to the node
     'authorId': the result of run "author_rotateKeys" from node
     */
    function joinCandidates(address _contract,uint256 amount,bytes32 authorId)  external returns (bool);

    /* @dev out of candidates by node ownner
    apply when staking.getNodeInfo(node).elected == false
    */
    function leaveCandidates()  external returns (bool);

    /* @dev update contract by node ownner
    '_contract':new contract address
     */
    function updateContract(address _contract)  external returns (bool);

    /* @dev update AuthorId by node ownner
     'author_id':the key of running node
     */
    function updateAuthorId(bytes32 author_id)  external returns (bool);

    /**
   * @dev Get the node contract address
     *
     */
    function getNodeContract(address nodeAccount) external view returns (address);

    /**
     * @dev Get the current operating status of the chain .
     *
     * Returns a boolean value indicating whether it can be operated.
     *
     * Note: If it is in the last 20 blocks of the campaign, it will be inoperable .
     * If the chain is inoperable, means can't deposit and withdraw GP, but still
     * can withdraw the block reward GS.
     */
    function chainOperateStatus() external view returns (bool);

    /**
     * @dev Get the current status of the node .
     *
     * Returns :
     *     0- not a node
     *     1- Candidate status
     *     2- Elected status
     *     3- Elected status and selected as the current 32 verification nodes
     *
     */
    function nodeStatus(address nodeAccount) external view returns (uint256);

    /**
     * @dev Get the minimum pledge amount of GP for node .
     *
     */
    function getMinStakeAmount() external view returns (uint256);

    /**
     * @dev Get the node account bound to the current contract .
     *
     */
    function getNodeAccount(address _contract) external view returns (address);

    /**
     * @dev Returns the GP amount of tokens owned by `account` of node.
     */
    function GPBalanceOf(address nodeAccount) external view returns (uint256);

    /**
     * @dev Returns the GS amount of tokens owned by node contract.
     */
    function GSBalanceOf(address contractAddress) external view returns (uint256);

    /**
    * @dev Staking `amount` of GPs to the node using the allowance mechanism.
     * `amount` is then deducted from the `account`'s GP Token allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Note: If the chainOperateStatus=false or the nodeStatus=0 , returns false;
     * otherwise returns true.
     *
     */
    function depositFrom(address account,uint256 amount) external returns (bool);

    /**
    * @dev Withdraw `amount` of GPs to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Note: If the chainOperateStatus=false or the nodeStatus=0 or not enough GP, returns false;
     * otherwise returns true.
     *
     */
    function withdrawTo(address recipient,uint256 amount) external returns (bool);


    /**
    * @dev withdraw `amount` of GS to the `recipient`. These GS have not yet been released.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     */
    function withdrawReward(address recipient,uint256 amount) external returns (bool);
}

