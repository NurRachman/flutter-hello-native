import 'dart:collection';

import 'package:flutter/material.dart';

class PrimitveStepper extends StatelessWidget {
  final LinkedHashMap dataStepper;
  final int activeIndex;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  final Function(int) onStepTapped;
  final VoidCallback onStepDone;
  const PrimitveStepper({
    Key? key,
    required this.dataStepper,
    required this.activeIndex,
    required this.onNext,
    required this.onPrev,
    required this.onStepTapped,
    required this.onStepDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataStepper.length,
      itemBuilder: (BuildContext context, int index) {
        String keys = dataStepper.keys.toList()[index];
        String value = dataStepper.values.toList()[index];
        bool isLast = activeIndex == dataStepper.length - 1;
        bool isFirst = index > 0;
        bool isActive = index == activeIndex;

        return InkWell(
          onTap: () => onStepTapped(index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(top: 8),
                    //   width: 1.5,
                    //   constraints: const BoxConstraints(
                    //     minHeight: 20,
                    //     maxHeight: 200,
                    //   ),
                    //   color: Colors.red,
                    //   child: const SizedBox(),
                    // ),
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        keys,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      isActive
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(value),
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        primary: Colors.white,
                                      ),
                                      onPressed: isLast ? onStepDone : onNext,
                                      child: Text(
                                        isLast ? 'Done' : 'Next',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    isFirst
                                        ? TextButton(
                                            style: TextButton.styleFrom(
                                              primary: Colors.grey,
                                            ),
                                            onPressed: onPrev,
                                            child: const Text('Previous'),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
