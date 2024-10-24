// coverage:ignore-file
import 'package:equatable/equatable.dart';

final class TezosBlockInfo extends Equatable {
  final int cycle;
  final int level;
  final String hash;
  final String timestamp;
  final int proto;
  final int payloadRound;
  final List<TezosTransaction> transactions;
  final int reward;
  final int bonus;
  final int fees;

  const TezosBlockInfo({
    required this.cycle,
    required this.level,
    required this.hash,
    required this.timestamp,
    required this.proto,
    required this.payloadRound,
    required this.transactions,
    required this.reward,
    required this.bonus,
    required this.fees,
  });

  const TezosBlockInfo.empty()
      : cycle = 0,
        level = 0,
        hash = '',
        timestamp = '',
        proto = 0,
        payloadRound = 0,
        transactions = const [],
        reward = 0,
        bonus = 0,
        fees = 0;

  factory TezosBlockInfo.fromJson(Map<String, dynamic> json) {
    return TezosBlockInfo(
      cycle: json['cycle'] ?? 0,
      level: json['level'] ?? 0,
      hash: json['hash'] ?? '',
      timestamp: json['timestamp'] ?? '',
      proto: json['proto'] ?? 0,
      payloadRound: json['payloadRound'] ?? 0,
      transactions: switch (json['transactions']) {
        List list => List<TezosTransaction>.from(
            list.map((x) => TezosTransaction.fromJson(x))),
        _ => const [],
      },
      reward: json['reward'] ?? 0,
      bonus: json['bonus'] ?? 0,
      fees: json['fees'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cycle': cycle,
      'level': level,
      'hash': hash,
      'timestamp': timestamp,
      'proto': proto,
      'payloadRound': payloadRound,
      'transactions': transactions.map((x) => x.toJson()).toList(),
      'reward': reward,
      'bonus': bonus,
      'fees': fees,
    };
  }

  @override
  List<Object> get props => [
        cycle,
        level,
        hash,
        timestamp,
        proto,
        payloadRound,
        transactions,
        reward,
        bonus,
        fees,
      ];
}

final class TezosTransaction extends Equatable {
  final String type;
  final int id;
  final int level;
  final String timestamp;
  final String block;
  final String hash;
  final int deposit;
  final int counter;
  final Initiator initiator;
  final Sender sender;
  final int senderCodeHash;
  final int nonce;
  final int gasLimit;
  final int gasUsed;
  final int storageLimit;
  final int storageUsed;
  final int bakerFee;
  final int storageFee;
  final int allocationFee;
  final Target target;
  final int targetCodeHash;
  final int amount;
  final Map<String, dynamic> parameter;
  final dynamic storage;
  final List<Diff> diffs;
  final String status;
  final List<Error> errors;
  final bool hasInternals;
  final int tokenTransfersCount;
  final int ticketTransfersCount;
  final int eventsCount;
  final Quote quote;

  const TezosTransaction({
    required this.type,
    required this.id,
    required this.level,
    required this.timestamp,
    required this.block,
    required this.hash,
    required this.deposit,
    required this.counter,
    required this.initiator,
    required this.sender,
    required this.senderCodeHash,
    required this.nonce,
    required this.gasLimit,
    required this.gasUsed,
    required this.storageLimit,
    required this.storageUsed,
    required this.bakerFee,
    required this.storageFee,
    required this.allocationFee,
    required this.target,
    required this.targetCodeHash,
    required this.amount,
    required this.parameter,
    required this.storage,
    required this.diffs,
    required this.status,
    required this.errors,
    required this.hasInternals,
    required this.tokenTransfersCount,
    required this.ticketTransfersCount,
    required this.eventsCount,
    required this.quote,
  });

  const TezosTransaction.empty()
      : type = '',
        id = 0,
        level = 0,
        timestamp = '',
        block = '',
        hash = '',
        deposit = 0,
        counter = 0,
        initiator = const Initiator.empty(),
        sender = const Sender.empty(),
        senderCodeHash = 0,
        nonce = 0,
        gasLimit = 0,
        gasUsed = 0,
        storageLimit = 0,
        storageUsed = 0,
        bakerFee = 0,
        storageFee = 0,
        allocationFee = 0,
        target = const Target.empty(),
        targetCodeHash = 0,
        amount = 0,
        parameter = const {},
        storage = null,
        diffs = const [],
        status = '',
        errors = const [],
        hasInternals = false,
        tokenTransfersCount = 0,
        ticketTransfersCount = 0,
        eventsCount = 0,
        quote = const Quote.empty();

  factory TezosTransaction.fromJson(Map<String, dynamic> json) {
    return TezosTransaction(
      type: json['type'] ?? '',
      id: json['id'] ?? 0,
      level: json['level'] ?? 0,
      timestamp: json['timestamp'] ?? '',
      block: json['block'] ?? '',
      hash: json['hash'] ?? '',
      deposit: json['deposit'] ?? 0,
      counter: json['counter'] ?? 0,
      initiator: Initiator.fromJson(json['initiator'] ?? {}),
      sender: Sender.fromJson(json['sender'] ?? {}),
      senderCodeHash: json['senderCodeHash'] ?? 0,
      nonce: json['nonce'] ?? 0,
      gasLimit: json['gasLimit'] ?? 0,
      gasUsed: json['gasUsed'] ?? 0,
      storageLimit: json['storageLimit'] ?? 0,
      storageUsed: json['storageUsed'] ?? 0,
      bakerFee: json['bakerFee'] ?? 0,
      storageFee: json['storageFee'] ?? 0,
      allocationFee: json['allocation_fee'] ?? 0,
      target: Target.fromJson(json['target'] ?? {}),
      targetCodeHash: json['targetCodeHash'] ?? 0,
      amount: json['amount'] ?? 0,
      parameter: json['parameter'] ?? {},
      storage: json['storage'],
      diffs: List<Diff>.from(
        json['diffs']?.map((x) => Diff.fromJson(x)) ?? [],
      ),
      status: json['status'] ?? '',
      errors: List<Error>.from(
        json['errors']?.map((x) => Error.fromJson(x)) ?? [],
      ),
      hasInternals: json['hasInternals'] ?? false,
      tokenTransfersCount: json['tokenTransfersCount'] ?? 0,
      ticketTransfersCount: json['ticketTransfersCount'] ?? 0,
      eventsCount: json['eventsCount'] ?? 0,
      quote: Quote.fromJson(json['quote'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'id': id,
      'level': level,
      'timestamp': timestamp,
      'block': block,
      'hash': hash,
      'deposit': deposit,
      'counter': counter,
      'initiator': initiator.toJson(),
      'sender': sender.toJson(),
      'senderCodeHash': senderCodeHash,
      'nonce': nonce,
      'gasLimit': gasLimit,
      'gasUsed': gasUsed,
      'storageLimit': storageLimit,
      'storageUsed': storageUsed,
      'bakerFee': bakerFee,
      'storageFee': storageFee,
      'allocationFee': allocationFee,
      'target': target.toJson(),
      'targetCodeHash': targetCodeHash,
      'amount': amount,
      'parameter': parameter,
      'storage': storage,
      'diffs': diffs.map((x) => x.toJson()).toList(),
      'status': status,
      'errors': errors.map((x) => x.toJson()).toList(),
      'hasInternals': hasInternals,
      'tokenTransfersCount': tokenTransfersCount,
      'ticketTransfersCount': ticketTransfersCount,
      'eventsCount': eventsCount,
      'quote': quote.toJson(),
    };
  }

  @override
  List<Object> get props {
    return [
      type,
      id,
      level,
      timestamp,
      block,
      hash,
      deposit,
      counter,
      initiator,
      sender,
      senderCodeHash,
      nonce,
      gasLimit,
      gasUsed,
      storageLimit,
      storageUsed,
      bakerFee,
      storageFee,
      allocationFee,
      target,
      targetCodeHash,
      amount,
      parameter,
      storage,
      diffs,
      status,
      errors,
      hasInternals,
      tokenTransfersCount,
      ticketTransfersCount,
      eventsCount,
      quote,
    ];
  }
}

final class Initiator extends Equatable {
  final String alias;
  final String address;

  const Initiator({
    required this.alias,
    required this.address,
  });

  const Initiator.empty()
      : alias = '',
        address = '';

  factory Initiator.fromJson(Map<String, dynamic> json) {
    return Initiator(
      alias: json['alias'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alias': alias,
      'address': address,
    };
  }

  @override
  List<Object> get props => [alias, address];
}

final class Sender extends Equatable {
  final String alias;
  final String address;

  const Sender({
    required this.alias,
    required this.address,
  });

  const Sender.empty()
      : alias = '',
        address = '';

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      alias: json['alias'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alias': alias,
      'address': address,
    };
  }

  @override
  List<Object?> get props => [alias, address];
}

final class Target extends Equatable {
  final String alias;
  final String address;

  const Target({
    required this.alias,
    required this.address,
  });

  const Target.empty()
      : alias = '',
        address = '';

  factory Target.fromJson(Map<String, dynamic> json) {
    return Target(
      alias: json['alias'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alias': alias,
      'address': address,
    };
  }

  @override
  List<Object> get props => [alias, address];
}

final class Diff extends Equatable {
  final int bigmap;
  final String path;
  final String action;
  final Map<String, dynamic> content;

  const Diff({
    required this.bigmap,
    required this.path,
    required this.action,
    required this.content,
  });

  factory Diff.fromJson(Map<String, dynamic> json) {
    return Diff(
      bigmap: json['bigmap'] ?? 0,
      path: json['path'] ?? '',
      action: json['action'] ?? '',
      content: json['content'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bigmap': bigmap,
      'path': path,
      'action': action,
      'content': content,
    };
  }

  @override
  List<Object> get props => [bigmap, path, action, content];
}

final class Error extends Equatable {
  final String type;

  const Error({
    required this.type,
  });

  const Error.empty() : type = '';

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
    };
  }

  @override
  List<Object> get props => [type];
}

final class Quote extends Equatable {
  final int btc;
  final int eur;
  final int usd;
  final int cny;
  final int jpy;
  final int krw;
  final int eth;
  final int gbp;

  const Quote({
    required this.btc,
    required this.eur,
    required this.usd,
    required this.cny,
    required this.jpy,
    required this.krw,
    required this.eth,
    required this.gbp,
  });

  const Quote.empty()
      : this(
          btc: 0,
          eur: 0,
          usd: 0,
          cny: 0,
          jpy: 0,
          krw: 0,
          eth: 0,
          gbp: 0,
        );

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      btc: json['btc'] ?? 0,
      eur: json['eur'] ?? 0,
      usd: json['usd'] ?? 0,
      cny: json['cny'] ?? 0,
      jpy: json['jpy'] ?? 0,
      krw: json['krw'] ?? 0,
      eth: json['eth'] ?? 0,
      gbp: json['gbp'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'btc': btc,
      'eur': eur,
      'usd': usd,
      'cny': cny,
      'jpy': jpy,
      'krw': krw,
      'eth': eth,
      'gbp': gbp,
    };
  }

  @override
  List<Object> get props => [btc, eur, usd, cny, jpy, krw, eth, gbp];
}
